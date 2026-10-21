import 'package:injectable/injectable.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/enable_biometric/view_model/enable_biometric_state.dart';
import 'package:applock/service/app_lock/biometric_service.dart';

@injectable
class EnableBiometricViewModel extends BaseCubit<EnableBiometricState> {
  final AppLockRepository _repository;
  final BiometricService _biometricService;

  EnableBiometricViewModel(this._repository, this._biometricService)
      : super(const EnableBiometricState());

  Future<void> checkBiometricAvailability() async {
    final supported = await _biometricService.canCheckBiometrics();
    emit(state.copyWith(isBiometricSupported: supported));
  }

  /// Returns `false` when biometrics are unavailable on this device.
  /// A cancelled prompt keeps the user on this screen.
  Future<bool> enableBiometric({required String localizedReason}) async {
    if (!await _biometricService.canCheckBiometrics()) return false;
    final authenticated = await _biometricService.authenticate(
      localizedReason: localizedReason,
    );
    if (!authenticated) return true;

    await _repository.setBiometricEnabled(true);
    emit(state.copyWith(
      isBiometricEnabled: true,
      isCompleted: true,
    ));
    return true;
  }

  Future<void> skip() async {
    await _repository.setBiometricEnabled(false);
    emit(state.copyWith(
      isBiometricEnabled: false,
      isCompleted: true,
    ));
  }
}
