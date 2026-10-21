import 'package:injectable/injectable.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/lock_screen/view_model/lock_screen_state.dart';
import 'package:applock/service/app_lock/biometric_service.dart';
import 'package:applock/utility/helper/nullable.dart';
import 'package:applock/utility/helper/result.dart';

@injectable
class LockScreenViewModel extends BaseCubit<LockScreenState> {
  final AppLockRepository _repository;
  final BiometricService _biometricService;
  String _savedPin = '1234';

  LockScreenViewModel(this._repository, this._biometricService)
      : super(const LockScreenState());

  Future<void> init({String? appName}) async {
    final configRes = await _repository.getLockConfig();
    var bioAvailable = false;

    if (configRes is Success) {
      final config = (configRes as Success).data;
      if (config.hasPinCode) {
        _savedPin = config.pinCode!;
      }
      if (config.isBiometricEnabled) {
        bioAvailable = await _biometricService.canCheckBiometrics();
      }
    }

    emit(state.copyWith(
      targetAppName: appName ?? state.targetAppName,
      isBiometricAvailable: bioAvailable,
    ));

    // Auto trigger biometric if enabled
    if (bioAvailable) {
      authenticateWithBiometric();
    }
  }

  void appendDigit(String digit) {
    if (state.currentInput.length >= 4) return;
    final newInput = state.currentInput + digit;
    emit(state.copyWith(
      currentInput: newInput,
      errorMessage: const Nullable(null),
      hasErrorShake: false,
    ));

    if (newInput.length == 4) {
      _verifyPin(newInput);
    }
  }

  void deleteDigit() {
    if (state.currentInput.isEmpty) return;
    final newInput = state.currentInput.substring(0, state.currentInput.length - 1);
    emit(state.copyWith(
      currentInput: newInput,
      errorMessage: const Nullable(null),
      hasErrorShake: false,
    ));
  }

  Future<void> authenticateWithBiometric() async {
    final success = await _biometricService.authenticate();
    if (success) {
      emit(state.copyWith(isUnlocked: true));
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
        errorMessage: const Nullable('Mã PIN không chính xác'),
      ));
    }
  }
}
