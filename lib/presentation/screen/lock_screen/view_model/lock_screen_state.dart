import 'dart:typed_data';

import 'package:applock/domain/model/lock_screen_args.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/lock_screen_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

/// Localizable error kinds shown on the lock screen.
enum LockScreenError {
  incorrectPin,
  incorrectPattern,
  patternTooShort,
  biometricFailed,
  deviceNotSecure,
}

class LockScreenState extends BaseState {
  final String currentInput;
  final List<int> currentPattern;
  final String? targetAppName;
  final String? targetPackageName;
  final Uint8List? appIcon;
  final LockScreenMode mode;
  final bool hasPin;
  final bool hasPattern;
  final bool isBiometricAvailable;
  final bool isUnlocked;
  final bool isSecurityReset;
  final bool hasErrorShake;
  final LockScreenStep step;
  final LockScreenStep previousUnlockStep;
  final LockScreenError? error;
  final bool isResetConfirmed;

  const LockScreenState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.currentInput = '',
    this.currentPattern = const [],
    this.targetAppName,
    this.targetPackageName,
    this.appIcon,
    this.mode = LockScreenMode.preview,
    this.hasPin = false,
    this.hasPattern = false,
    this.isBiometricAvailable = false,
    this.isUnlocked = false,
    this.isSecurityReset = false,
    this.hasErrorShake = false,
    this.step = LockScreenStep.pin,
    this.previousUnlockStep = LockScreenStep.pin,
    this.error,
    this.isResetConfirmed = false,
  });

  /// Whether the user can switch between PIN and pattern.
  bool get canSwitchMethod => hasPin && hasPattern;

  @override
  LockScreenState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    String? currentInput,
    List<int>? currentPattern,
    Nullable<String>? targetAppName,
    Nullable<String>? targetPackageName,
    Nullable<Uint8List>? appIcon,
    LockScreenMode? mode,
    bool? hasPin,
    bool? hasPattern,
    bool? isBiometricAvailable,
    bool? isUnlocked,
    bool? isSecurityReset,
    bool? hasErrorShake,
    LockScreenStep? step,
    LockScreenStep? previousUnlockStep,
    Nullable<LockScreenError>? error,
    bool? isResetConfirmed,
  }) {
    return LockScreenState(
      status: status ?? this.status,
      errorMessage:
          errorMessage != null ? errorMessage.value : this.errorMessage,
      currentInput: currentInput ?? this.currentInput,
      currentPattern: currentPattern ?? this.currentPattern,
      targetAppName:
          targetAppName != null ? targetAppName.value : this.targetAppName,
      targetPackageName: targetPackageName != null
          ? targetPackageName.value
          : this.targetPackageName,
      appIcon: appIcon != null ? appIcon.value : this.appIcon,
      mode: mode ?? this.mode,
      hasPin: hasPin ?? this.hasPin,
      hasPattern: hasPattern ?? this.hasPattern,
      isBiometricAvailable: isBiometricAvailable ?? this.isBiometricAvailable,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      isSecurityReset: isSecurityReset ?? this.isSecurityReset,
      hasErrorShake: hasErrorShake ?? this.hasErrorShake,
      step: step ?? this.step,
      previousUnlockStep: previousUnlockStep ?? this.previousUnlockStep,
      error: error != null ? error.value : this.error,
      isResetConfirmed: isResetConfirmed ?? this.isResetConfirmed,
    );
  }
}
