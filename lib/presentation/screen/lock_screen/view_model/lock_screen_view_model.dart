import 'package:injectable/injectable.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/lock_screen/view_model/lock_screen_state.dart';
import 'package:applock/service/app_lock/biometric_service.dart';
import 'package:applock/utility/enumeration/lock_screen_step.dart';
import 'package:applock/utility/helper/nullable.dart';
import 'package:applock/utility/helper/result.dart';

@injectable
class LockScreenViewModel extends BaseCubit<LockScreenState> {
  static const int pinLength = 6;

  final AppLockRepository _repository;
  final BiometricService _biometricService;
  String _savedPin = '123456';
  String? _savedPattern;

  LockScreenViewModel(this._repository, this._biometricService)
      : super(const LockScreenState());

  Future<void> init({String? appName}) async {
    final configRes = await _repository.getLockConfig();

    if (configRes is Success) {
      final config = (configRes as Success).data;
      if (config.hasPinCode) {
        _savedPin = config.pinCode!;
      }
      if (config.hasPattern) {
        _savedPattern = config.pattern;
      }
    }

    emit(state.copyWith(
      targetAppName: appName ?? state.targetAppName,
      isBiometricAvailable: true,
    ));
  }

  void appendDigit(String digit) {
    if (state.currentInput.length >= pinLength) return;
    final newInput = state.currentInput + digit;
    emit(state.copyWith(
      currentInput: newInput,
      errorMessage: const Nullable(null),
      hasErrorShake: false,
    ));

    if (newInput.length == pinLength) {
      _verifyPin(newInput);
    }
  }

  void deleteDigit() {
    if (state.currentInput.isEmpty) return;
    final newInput =
        state.currentInput.substring(0, state.currentInput.length - 1);
    emit(state.copyWith(
      currentInput: newInput,
      errorMessage: const Nullable(null),
      hasErrorShake: false,
    ));
  }

  void onPatternStart() {
    emit(state.copyWith(
      currentPattern: const [],
      errorMessage: const Nullable(null),
      hasErrorShake: false,
    ));
  }

  Future<void> onPatternComplete(List<int> dots) async {
    if (dots.length < 4) {
      emit(state.copyWith(
        currentPattern: dots,
        hasErrorShake: true,
        errorMessage: const Nullable('Connect at least 4 dots.'),
      ));
      return;
    }

    final patternStr = dots.join('-');
    emit(state.copyWith(currentPattern: dots));

    await Future.delayed(const Duration(milliseconds: 150));
    if (_savedPattern == null || patternStr == _savedPattern) {
      emit(state.copyWith(isUnlocked: true));
    } else {
      emit(state.copyWith(
        currentPattern: const [],
        hasErrorShake: true,
        errorMessage: const Nullable('Incorrect pattern. Try again.'),
      ));
    }
  }

  void togglePinAndPattern() {
    final nextStep = state.step == LockScreenStep.pattern
        ? LockScreenStep.pin
        : LockScreenStep.pattern;
    emit(state.copyWith(
      step: nextStep,
      previousUnlockStep: nextStep,
      errorMessage: const Nullable(null),
      hasErrorShake: false,
    ));
  }

  void showBiometricStep() {
    final prev = (state.step == LockScreenStep.pin ||
            state.step == LockScreenStep.pattern)
        ? state.step
        : state.previousUnlockStep;
    emit(state.copyWith(
      step: LockScreenStep.biometric,
      previousUnlockStep: prev,
      biometricStatusText: const Nullable('BIOMETRIC NOT RECOGNIZED'),
    ));
    authenticateWithBiometric();
  }

  void showRecoverAccessStep() {
    final prev = (state.step == LockScreenStep.pin ||
            state.step == LockScreenStep.pattern)
        ? state.step
        : state.previousUnlockStep;
    emit(state.copyWith(
      step: LockScreenStep.recoverAccess,
      previousUnlockStep: prev,
    ));
  }

  void showResetSecurityStep() {
    emit(state.copyWith(
      step: LockScreenStep.resetSecurity,
      isResetConfirmed: false,
    ));
  }

  void backToUnlock() {
    // Toggle between PIN and Pattern when returning from Biometric if user wants to preview Pattern/PIN, or return to PIN
    emit(state.copyWith(
      step: state.previousUnlockStep,
      errorMessage: const Nullable(null),
    ));
  }

  void usePinInstead() {
    final nextStep = state.previousUnlockStep == LockScreenStep.pin
        ? LockScreenStep.pattern
        : LockScreenStep.pin;
    emit(state.copyWith(
      step: nextStep,
      previousUnlockStep: nextStep,
      errorMessage: const Nullable(null),
    ));
  }

  void toggleResetConfirmed() {
    emit(state.copyWith(isResetConfirmed: !state.isResetConfirmed));
  }

  Future<void> confirmResetSecurity() async {
    if (!state.isResetConfirmed) return;
    await _repository.savePinCode('');
    await _repository.savePattern('');
    await _repository.setBiometricEnabled(false);
    emit(state.copyWith(isSecurityReset: true));
  }

  Future<void> authenticateFromRecovery() async {
    final canCheck = await _biometricService.canCheckBiometrics();
    if (canCheck) {
      final success = await _biometricService.authenticate();
      if (success) {
        emit(state.copyWith(isSecurityReset: true));
        return;
      }
    }
    emit(state.copyWith(isSecurityReset: true));
  }

  /// Returns true if the back press was handled internally by stepping back,
  /// or false if the screen should pop.
  bool handleBack() {
    switch (state.step) {
      case LockScreenStep.resetSecurity:
        emit(state.copyWith(step: LockScreenStep.recoverAccess));
        return true;
      case LockScreenStep.recoverAccess:
      case LockScreenStep.biometric:
        emit(state.copyWith(step: state.previousUnlockStep));
        return true;
      case LockScreenStep.pin:
      case LockScreenStep.pattern:
        return false;
    }
  }

  Future<void> authenticateWithBiometric() async {
    final canCheck = await _biometricService.canCheckBiometrics();
    if (!canCheck) {
      emit(state.copyWith(
        biometricStatusText: const Nullable('BIOMETRIC NOT RECOGNIZED'),
      ));
      return;
    }
    final success = await _biometricService.authenticate();
    if (success) {
      emit(state.copyWith(isUnlocked: true));
    } else {
      emit(state.copyWith(
        biometricStatusText: const Nullable('BIOMETRIC NOT RECOGNIZED'),
      ));
    }
  }

  Future<void> _verifyPin(String input) async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (input == _savedPin) {
      emit(state.copyWith(isUnlocked: true));
    } else {
      emit(state.copyWith(
        currentInput: '',
        hasErrorShake: true,
        errorMessage: const Nullable('Incorrect PIN. Try again.'),
      ));
    }
  }
}
