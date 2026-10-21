import 'package:injectable/injectable.dart';
import 'package:applock/domain/model/app_lock_item.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/home/view_model/home_state.dart';
import 'package:applock/service/app_lock/biometric_service.dart';
import 'package:applock/utility/enumeration/home_theme_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/result.dart';

@injectable
class HomeViewModel extends BaseCubit<HomeState> {
  final AppLockRepository _repository;
  final BiometricService _biometricService;

  HomeViewModel(
    this._repository,
    this._biometricService,
  ) : super(const HomeState());

  Future<void> init() async {
    emit(state.copyWith(status: ViewStatus.loading));

    final configRes = await _repository.getLockConfig();
    var isService = false;
    var isBio = false;

    if (configRes is Success) {
      final config = (configRes as Success).data;
      isService = config.isServiceActive;
      isBio = config.isBiometricEnabled;
    }

    var lockedCount = state.lockedCount;
    final appsResult = await _repository.getInstalledApps();
    if (appsResult is Success<List<AppLockItem>>) {
      lockedCount = appsResult.data.where((a) => a.isLocked).length;
    }

    emit(state.copyWith(
      status: ViewStatus.success,
      lockedCount: lockedCount,
      isServiceActive: isService,
      isBiometricEnabled: isBio,
    ));
  }

  void setThemeStep(HomeThemeStep step) {
    emit(state.copyWith(currentStep: step));
  }

  Future<void> toggleBiometric(bool active) async {
    if (active) {
      final canCheck = await _biometricService.canCheckBiometrics();
      if (!canCheck) {
        emitError('Thiết bị không hỗ trợ hoặc chưa cài sinh trắc học');
        return;
      }
      final authenticated = await _biometricService.authenticate();
      if (!authenticated) return;
    }
    await _repository.setBiometricEnabled(active);
    emit(state.copyWith(isBiometricEnabled: active));
  }
}
