import 'package:injectable/injectable.dart';
import 'package:applock/domain/model/lock_config.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/domain/repository/intruder_repository.dart';
import 'package:applock/domain/repository/vault_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/home/view_model/home_state.dart';
import 'package:applock/service/app_lock/app_lock_service.dart';
import 'package:applock/service/app_lock/biometric_service.dart';
import 'package:applock/utility/enumeration/biometric_toggle_result.dart';
import 'package:applock/utility/enumeration/home_theme_step.dart';
import 'package:applock/utility/enumeration/lock_screen_theme.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/result.dart';

@injectable
class HomeViewModel extends BaseCubit<HomeState> {
  final AppLockRepository _repository;
  final VaultRepository _vaultRepository;
  final IntruderRepository _intruderRepository;
  final BiometricService _biometricService;
  final AppLockService _appLockService;

  HomeViewModel(
    this._repository,
    this._vaultRepository,
    this._intruderRepository,
    this._biometricService,
    this._appLockService,
  ) : super(const HomeState());

  Future<void> init() async {
    if (state.status == ViewStatus.initial) {
      emit(state.copyWith(status: ViewStatus.loading));
    }

    final configRes = await _repository.getLockConfig();
    final lockedRes = await _repository.getLockedPackageNames();
    final vaultRes = await _vaultRepository.getItemCount();
    final alertsRes = await _intruderRepository.getAlertCount();
    final isRunning = await _appLockService.isServiceRunning();
    final themeRes = await _repository.getLockScreenTheme();

    final config = configRes is Success<LockConfig>
        ? configRes.data
        : const LockConfig();

    if (isClosed) return;
    emit(state.copyWith(
      status: ViewStatus.success,
      lockedCount: lockedRes is Success<Set<String>> ? lockedRes.data.length : 0,
      vaultItemsCount: vaultRes is Success<int> ? vaultRes.data : 0,
      intruderAlertsCount: alertsRes is Success<int> ? alertsRes.data : 0,
      isServiceActive: isRunning,
      isBiometricEnabled: config.isBiometricEnabled,
      lockScreenTheme: themeRes is Success<LockScreenTheme>
          ? themeRes.data
          : state.lockScreenTheme,
    ));
  }

  Future<void> applyLockScreenTheme(LockScreenTheme theme) async {
    await _repository.saveLockScreenTheme(theme);
    emit(state.copyWith(
      lockScreenTheme: theme,
      currentStep: HomeThemeStep.themeApplied,
    ));
  }

  void setThemeStep(HomeThemeStep step) {
    emit(state.copyWith(currentStep: step));
  }

  Future<BiometricToggleResult> toggleBiometric(
    bool active, {
    required String localizedReason,
  }) async {
    if (active) {
      if (!await _biometricService.canCheckBiometrics()) {
        return BiometricToggleResult.notSupported;
      }
      final ok = await _biometricService.authenticate(
        localizedReason: localizedReason,
      );
      if (!ok) return BiometricToggleResult.cancelled;
    }
    await _repository.setBiometricEnabled(active);
    emit(state.copyWith(isBiometricEnabled: active));
    return BiometricToggleResult.success;
  }
}
