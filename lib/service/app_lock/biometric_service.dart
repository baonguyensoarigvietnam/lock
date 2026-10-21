import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

@lazySingleton
class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> canCheckBiometrics() async {
    try {
      final canAuthenticateWithBiometrics = await _auth.canCheckBiometrics;
      final canAuthenticate =
          canAuthenticateWithBiometrics || await _auth.isDeviceSupported();
      return canAuthenticate;
    } catch (_) {
      return false;
    }
  }

  Future<bool> authenticate({
    String localizedReason = 'Vui lòng xác thực sinh trắc học để mở khoá',
  }) async {
    try {
      return await _auth.authenticate(
        localizedReason: localizedReason,
      );
    } catch (_) {
      return false;
    }
  }
}
