import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/lock_screen_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class LockScreenState extends BaseState {
  final String currentInput;
  final List<int> currentPattern;
  final String targetAppName;
  final bool isBiometricAvailable;
  final bool isUnlocked;
  final bool isSecurityReset;
  final bool hasErrorShake;
  final LockScreenStep step;
  final LockScreenStep previousUnlockStep;
  final String? biometricStatusText;
  final bool isResetConfirmed;

  const LockScreenState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.currentInput = '',
    this.currentPattern = const [0, 1, 5, 7],
    this.targetAppName = 'Gallery',
    this.isBiometricAvailable = true,
    this.isUnlocked = false,
    this.isSecurityReset = false,
    this.hasErrorShake = false,
    this.step = LockScreenStep.pin,
    this.previousUnlockStep = LockScreenStep.pin,
    this.biometricStatusText = 'BIOMETRIC NOT RECOGNIZED',
    this.isResetConfirmed = false,
  });

  @override
  LockScreenState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    String? currentInput,
    List<int>? currentPattern,
    String? targetAppName,
    bool? isBiometricAvailable,
    bool? isUnlocked,
    bool? isSecurityReset,
    bool? hasErrorShake,
    LockScreenStep? step,
    LockScreenStep? previousUnlockStep,
    Nullable<String>? biometricStatusText,
    bool? isResetConfirmed,
  }) {
    return LockScreenState(
      status: status ?? this.status,
      errorMessage:
          errorMessage != null ? errorMessage.value : this.errorMessage,
      currentInput: currentInput ?? this.currentInput,
      currentPattern: currentPattern ?? this.currentPattern,
      targetAppName: targetAppName ?? this.targetAppName,
      isBiometricAvailable: isBiometricAvailable ?? this.isBiometricAvailable,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      isSecurityReset: isSecurityReset ?? this.isSecurityReset,
      hasErrorShake: hasErrorShake ?? this.hasErrorShake,
      step: step ?? this.step,
      previousUnlockStep: previousUnlockStep ?? this.previousUnlockStep,
      biometricStatusText: biometricStatusText != null
          ? biometricStatusText.value
          : this.biometricStatusText,
      isResetConfirmed: isResetConfirmed ?? this.isResetConfirmed,
    );
  }
}
