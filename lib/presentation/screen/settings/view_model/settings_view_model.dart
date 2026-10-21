import 'package:injectable/injectable.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/settings/view_model/settings_state.dart';
import 'package:applock/service/app_lock/biometric_service.dart';
import 'package:applock/utility/enumeration/settings_tab_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/result.dart';

@injectable
class SettingsViewModel extends BaseCubit<SettingsState> {
  final AppLockRepository _repository;
  final BiometricService _biometricService;

  SettingsViewModel(
    this._repository,
    this._biometricService,
  ) : super(const SettingsState());

  Future<void> init() async {
    final configRes = await _repository.getLockConfig();
    var isBio = false;

    if (configRes is Success) {
      final config = (configRes as Success).data;
      isBio = config.isBiometricEnabled;
    }

    emit(state.copyWith(
      status: ViewStatus.success,
      isBiometricEnabled: isBio,
    ));
  }

  void setStep(SettingsTabStep step) {
    emit(state.copyWith(currentStep: step));
  }

  void startChangePin() {
    emit(state.copyWith(
      firstPin: '',
      currentStep: SettingsTabStep.changePin,
    ));
  }

  void submitFirstPin(String pin) {
    emit(state.copyWith(
      firstPin: pin,
      currentStep: SettingsTabStep.confirmPin,
    ));
  }

  void submitFirstPattern(List<int> pattern) {
    emit(state.copyWith(
      firstPattern: pattern,
      currentStep: SettingsTabStep.confirmPattern,
    ));
  }

  void saveAutoLockDelay(String delay) {
    emit(state.copyWith(
      autoLockDelay: delay,
      currentStep: SettingsTabStep.overview,
    ));
  }

  void saveLanguage(String language) {
    emit(state.copyWith(
      selectedLanguage: language,
      currentStep: SettingsTabStep.overview,
    ));
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
