import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/app_language.dart';
import 'package:applock/utility/enumeration/auto_lock_delay.dart';
import 'package:applock/utility/enumeration/settings_tab_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class SettingsState extends BaseState {
  final SettingsTabStep currentStep;
  final bool isBiometricEnabled;
  final String firstPin;
  final List<int> firstPattern;
  final AutoLockDelay autoLockDelay;
  final AppLanguage selectedLanguage;

  const SettingsState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.currentStep = SettingsTabStep.overview,
    this.isBiometricEnabled = false,
    this.firstPin = '',
    this.firstPattern = const [],
    this.autoLockDelay = AutoLockDelay.immediately,
    this.selectedLanguage = AppLanguage.en,
  });

  @override
  SettingsState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    SettingsTabStep? currentStep,
    bool? isBiometricEnabled,
    String? firstPin,
    List<int>? firstPattern,
    AutoLockDelay? autoLockDelay,
    AppLanguage? selectedLanguage,
  }) {
    return SettingsState(
      status: status ?? this.status,
      errorMessage:
          errorMessage != null ? errorMessage.value : this.errorMessage,
      currentStep: currentStep ?? this.currentStep,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      firstPin: firstPin ?? this.firstPin,
      firstPattern: firstPattern ?? this.firstPattern,
      autoLockDelay: autoLockDelay ?? this.autoLockDelay,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }
}
