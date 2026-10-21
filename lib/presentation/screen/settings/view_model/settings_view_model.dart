import 'package:injectable/injectable.dart';
import 'package:applock/domain/model/lock_config.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/settings/view_model/settings_state.dart';
import 'package:applock/service/app_lock/biometric_service.dart';
import 'package:applock/service/app_lock/lock_engine_coordinator.dart';
import 'package:applock/utility/enumeration/app_language.dart';
import 'package:applock/utility/enumeration/auto_lock_delay.dart';
import 'package:applock/utility/enumeration/biometric_toggle_result.dart';
import 'package:applock/utility/enumeration/settings_tab_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/result.dart';

@injectable
class SettingsViewModel extends BaseCubit<SettingsState> {
  final AppLockRepository _repository;
  final BiometricService _biometricService;
  final LockEngineCoordinator _lockEngineCoordinator;

  SettingsViewModel(
    this._repository,
    this._biometricService,
    this._lockEngineCoordinator,
  ) : super(const SettingsState());

  Future<void> init() async {
    final configRes = await _repository.getLockConfig();
    final langRes = await _repository.getLanguageCode();
    final delayRes = await _repository.getAutoLockDelay();

    final isBio =
        configRes is Success<LockConfig> && configRes.data.isBiometricEnabled;
    final language = langRes is Success<String>
        ? AppLanguage.fromCode(langRes.data)
        : state.selectedLanguage;
    final delay = delayRes is Success<AutoLockDelay>
        ? delayRes.data
        : state.autoLockDelay;

    if (isClosed) return;
    emit(state.copyWith(
      status: ViewStatus.success,
      isBiometricEnabled: isBio,
      selectedLanguage: language,
      autoLockDelay: delay,
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

  void startChangePattern() {
    emit(state.copyWith(
      firstPattern: const [],
      currentStep: SettingsTabStep.changePattern,
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

  /// Persists the confirmed PIN. Returns whether it was saved.
  Future<bool> confirmPin() async {
    final pin = state.firstPin;
    if (pin.isEmpty) return false;
    final res = await _repository.savePinCode(pin);
    if (res is! Success) return false;
    emit(state.copyWith(firstPin: '', currentStep: SettingsTabStep.overview));
    return true;
  }

  /// Persists the confirmed pattern. Returns whether it was saved.
  Future<bool> confirmPattern() async {
    final pattern = state.firstPattern;
    if (pattern.length < 4) return false;
    final res = await _repository.savePattern(pattern.join(','));
    if (res is! Success) return false;
    emit(state.copyWith(
      firstPattern: const [],
      currentStep: SettingsTabStep.overview,
    ));
    return true;
  }

  Future<void> saveAutoLockDelay(AutoLockDelay delay) async {
    await _repository.saveAutoLockDelay(delay);
    await _lockEngineCoordinator.syncRelockPolicy(delay);
    emit(state.copyWith(
      autoLockDelay: delay,
      currentStep: SettingsTabStep.overview,
    ));
  }

  Future<void> saveLanguage(AppLanguage language) async {
    await _repository.saveLanguageCode(language.code);
    emit(state.copyWith(
      selectedLanguage: language,
      currentStep: SettingsTabStep.overview,
    ));
  }

  Future<BiometricToggleResult> toggleBiometric(
    bool active, {
    required String localizedReason,
  }) async {
    if (active) {
      if (!await _biometricService.canCheckBiometrics()) {
        return BiometricToggleResult.notSupported;
      }
      final authenticated = await _biometricService.authenticate(
        localizedReason: localizedReason,
      );
      if (!authenticated) return BiometricToggleResult.cancelled;
    }
    await _repository.setBiometricEnabled(active);
    emit(state.copyWith(isBiometricEnabled: active));
    return BiometricToggleResult.success;
  }
}
