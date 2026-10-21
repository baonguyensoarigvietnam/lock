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

  Future<void> enableBiometric() async {
    final authenticated = await _biometricService.authenticate(
      localizedReason: 'Xác thực để kích hoạt mở khoá bằng sinh trắc học',
    );

    // If authenticated (or even if cancelled/unsupported on simulator, proceed with saving setting)
    await _repository.setBiometricEnabled(authenticated);
    emit(state.copyWith(
      isBiometricEnabled: authenticated,
      isCompleted: true,
    ));
  }

  Future<void> skip() async {
    await _repository.setBiometricEnabled(false);
    emit(state.copyWith(
      isBiometricEnabled: false,
      isCompleted: true,
    ));
  }
}
