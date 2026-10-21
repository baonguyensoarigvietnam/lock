import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:applock/domain/model/lock_config.dart';
import 'package:applock/domain/model/lock_screen_args.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/lock_screen/view_model/lock_screen_state.dart';
import 'package:applock/service/app_lock/app_lock_service.dart';
import 'package:applock/service/app_lock/biometric_service.dart';
import 'package:applock/service/intruder/intruder_service.dart';
import 'package:applock/utility/enumeration/intruder_unlock_method.dart';
import 'package:applock/utility/enumeration/lock_screen_step.dart';
import 'package:applock/utility/enumeration/lock_screen_theme.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';
import 'package:applock/utility/helper/result.dart';

@injectable
class LockScreenViewModel extends BaseCubit<LockScreenState> {
  static const int pinLength = 6;
  static const int minPatternDots = 4;

  final AppLockRepository _repository;
  final BiometricService _biometricService;
  final AppLockService _appLockService;
  final IntruderService _intruderService;

  String? _savedPin;
  String? _savedPattern;

  /// Real name of the protected app (kept even when the theme hides it).
  String? _protectedAppName;

  LockScreenViewModel(
    this._repository,
    this._biometricService,
    this._appLockService,
    this._intruderService,
  ) : super(const LockScreenState());

  Future<void> init(LockScreenArgs args) async {
    final configRes = await _repository.getLockConfig();
    final config = configRes is Success<LockConfig>
        ? configRes.data
        : const LockConfig();

    _savedPin = config.hasPinCode ? config.pinCode : null;
    _savedPattern = config.hasPattern ? config.pattern : null;

    final bioAvailable = config.isBiometricEnabled &&
        await _biometricService.canCheckBiometrics();

    final themeRes = await _repository.getLockScreenTheme();
    final theme = themeRes is Success<LockScreenTheme>
        ? themeRes.data
        : LockScreenTheme.vault;

    final preferPattern = _savedPattern != null &&
        (_savedPin == null || theme == LockScreenTheme.pattern);
    final initialStep =
        preferPattern ? LockScreenStep.pattern : LockScreenStep.pin;

    // Focus theme hides which app is being unlocked.
    final hideIdentity = theme == LockScreenTheme.focus;
    _protectedAppName = args.appName;

    emit(state.copyWith(
      status: ViewStatus.success,
      mode: args.mode,
      targetAppName: Nullable(hideIdentity ? null : args.appName),
      targetPackageName: Nullable(args.packageName),
      hasPin: _savedPin != null,
      hasPattern: _savedPattern != null,
      isBiometricAvailable: bioAvailable,
      step: initialStep,
      previousUnlockStep: initialStep,
    ));

    final showIcon =
        theme != LockScreenTheme.minimal && theme != LockScreenTheme.focus;
    if (showIcon) _loadAppIcon(args.packageName);

    // No secret configured at all (e.g. after a reset): nothing to verify.
    if (_savedPin == null && _savedPattern == null) {
      emit(state.copyWith(isSecurityReset: true));
    }
  }

  Future<void> _loadAppIcon(String? packageName) async {
    if (packageName == null || !Platform.isAndroid) return;
    try {
      final info = await InstalledApps.getAppInfo(packageName, null);
      if (info?.icon != null && !isClosed) {
        emit(state.copyWith(
          appIcon: Nullable(info!.icon),
          targetAppName: Nullable(state.targetAppName ?? info.name),
        ));
      }
    } catch (_) {
      // Icon is optional.
    }
  }

  /// Sends App Lock to the background after an external unlock.
  Future<void> returnToProtectedApp() => _appLockService.moveToBack();

  void appendDigit(String digit) {
    if (state.currentInput.length >= pinLength) return;
    final newInput = state.currentInput + digit;
    emit(state.copyWith(
      currentInput: newInput,
      error: const Nullable(null),
      hasErrorShake: false,
    ));

    if (newInput.length == pinLength) {
      _verifyPin(newInput);
    }
  }

  void deleteDigit() {
    if (state.currentInput.isEmpty) return;
    emit(state.copyWith(
      currentInput:
          state.currentInput.substring(0, state.currentInput.length - 1),
      error: const Nullable(null),
      hasErrorShake: false,
    ));
  }

  void onPatternStart() {
    emit(state.copyWith(
      currentPattern: const [],
      error: const Nullable(null),
      hasErrorShake: false,
    ));
  }

  Future<void> onPatternComplete(List<int> dots) async {
    if (dots.length < minPatternDots) {
      emit(state.copyWith(
        currentPattern: dots,
        hasErrorShake: true,
        error: const Nullable(LockScreenError.patternTooShort),
      ));
      return;
    }

    emit(state.copyWith(currentPattern: dots));
    await Future.delayed(const Duration(milliseconds: 150));

    if (_patternMatches(dots)) {
      await _onUnlocked();
    } else {
      await _onFailedAttempt(IntruderUnlockMethod.pattern);
      emit(state.copyWith(
        currentPattern: const [],
        hasErrorShake: true,
        error: const Nullable(LockScreenError.incorrectPattern),
      ));
    }
  }

  bool _patternMatches(List<int> dots) {
    final saved = _savedPattern;
    if (saved == null) return false;
    final normalized = saved.replaceAll('-', ',');
    return dots.join(',') == normalized;
  }

  void togglePinAndPattern() {
    if (!state.canSwitchMethod) return;
    final nextStep = state.step == LockScreenStep.pattern
        ? LockScreenStep.pin
        : LockScreenStep.pattern;
    emit(state.copyWith(
      step: nextStep,
      previousUnlockStep: nextStep,
      currentInput: '',
      currentPattern: const [],
      error: const Nullable(null),
      hasErrorShake: false,
    ));
  }

  void showBiometricStep(String localizedReason) {
    if (!state.isBiometricAvailable) return;
    final prev = (state.step == LockScreenStep.pin ||
            state.step == LockScreenStep.pattern)
        ? state.step
        : state.previousUnlockStep;
    emit(state.copyWith(
      step: LockScreenStep.biometric,
      previousUnlockStep: prev,
      error: const Nullable(null),
    ));
    authenticateWithBiometric(localizedReason);
  }

  void showRecoverAccessStep() {
    final prev = (state.step == LockScreenStep.pin ||
            state.step == LockScreenStep.pattern)
        ? state.step
        : state.previousUnlockStep;
    emit(state.copyWith(
      step: LockScreenStep.recoverAccess,
      previousUnlockStep: prev,
      error: const Nullable(null),
    ));
  }

  void showResetSecurityStep() {
    emit(state.copyWith(
      step: LockScreenStep.resetSecurity,
      isResetConfirmed: false,
      error: const Nullable(null),
    ));
  }

  void backToUnlock() {
    emit(state.copyWith(
      step: state.previousUnlockStep,
      error: const Nullable(null),
    ));
  }

  /// From the biometric step: go back to the PIN/pattern the user came from.
  void usePinInstead() => backToUnlock();

  void toggleResetConfirmed() {
    emit(state.copyWith(isResetConfirmed: !state.isResetConfirmed));
  }

  /// Wipes the App Lock secret. Requires device authentication (biometric or
  /// device PIN) so this can't be used to bypass the lock.
  Future<void> confirmResetSecurity(String localizedReason) async {
    if (!state.isResetConfirmed) return;
    if (!await _verifyDeviceOwner(localizedReason)) return;
    await _repository.savePinCode('');
    await _repository.savePattern('');
    await _repository.setBiometricEnabled(false);
    emit(state.copyWith(isSecurityReset: true));
  }

  /// "Forgot PIN" recovery using the device's own screen lock.
  Future<void> authenticateFromRecovery(String localizedReason) async {
    if (!await _verifyDeviceOwner(localizedReason)) return;
    await _repository.savePinCode('');
    await _repository.savePattern('');
    emit(state.copyWith(isSecurityReset: true));
  }

  Future<bool> _verifyDeviceOwner(String localizedReason) async {
    if (!await _biometricService.isDeviceSecure()) {
      emit(state.copyWith(error: const Nullable(LockScreenError.deviceNotSecure)));
      return false;
    }
    final ok = await _biometricService.authenticate(
      localizedReason: localizedReason,
      biometricOnly: false,
    );
    if (!ok) {
      emit(state.copyWith(error: const Nullable(LockScreenError.biometricFailed)));
    }
    return ok;
  }

  /// Returns true if the back press was handled internally by stepping back,
  /// or false if the screen should be left.
  bool handleBack() {
    switch (state.step) {
      case LockScreenStep.resetSecurity:
        emit(state.copyWith(step: LockScreenStep.recoverAccess));
        return true;
      case LockScreenStep.recoverAccess:
      case LockScreenStep.biometric:
        emit(state.copyWith(
          step: state.previousUnlockStep,
          error: const Nullable(null),
        ));
        return true;
      case LockScreenStep.pin:
      case LockScreenStep.pattern:
        return false;
    }
  }

  Future<void> authenticateWithBiometric(String localizedReason) async {
    final success = await _biometricService.authenticate(
      localizedReason: localizedReason,
    );
    if (success) {
      await _onUnlocked();
    } else {
      // A dismissed system prompt is indistinguishable from a failed match,
      // so biometrics do not count towards intruder capture.
      emit(state.copyWith(
        error: const Nullable(LockScreenError.biometricFailed),
      ));
    }
  }

  /// Leaves a protected app without unlocking (external mode).
  Future<void> leaveProtectedApp() => _appLockService.goHome();

  Future<void> _verifyPin(String input) async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (_savedPin != null && input == _savedPin) {
      await _onUnlocked();
    } else {
      await _onFailedAttempt(IntruderUnlockMethod.pin);
      emit(state.copyWith(
        currentInput: '',
        hasErrorShake: true,
        error: const Nullable(LockScreenError.incorrectPin),
      ));
    }
  }

  Future<void> _onUnlocked() async {
    _intruderService.resetFailedAttempts();
    final pkg = state.targetPackageName;
    if (state.mode == LockScreenMode.external && pkg != null) {
      await _appLockService.markUnlocked(pkg);
    }
    emit(state.copyWith(isUnlocked: true, error: const Nullable(null)));
  }

  Future<void> _onFailedAttempt(IntruderUnlockMethod method) async {
    // Previews inside the app are not intrusion attempts.
    if (state.mode == LockScreenMode.preview) return;
    await _intruderService.recordFailedAttempt(
      appName: state.mode == LockScreenMode.external
          ? (_protectedAppName ?? state.targetAppName)
          : null,
      method: method,
    );
  }
}
