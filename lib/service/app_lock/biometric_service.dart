import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

@lazySingleton
class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  /// Whether at least one biometric is enrolled and usable.
  Future<bool> canCheckBiometrics() async {
    try {
      if (!await _auth.canCheckBiometrics) return false;
      final available = await _auth.getAvailableBiometrics();
      return available.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  /// Whether the device has any secure lock (biometric or PIN/pattern/password).
  Future<bool> isDeviceSecure() async {
    try {
      return await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  /// Shows the system biometric prompt. [localizedReason] must come from l10n.
  ///
  /// When [biometricOnly] is false the user may fall back to the device
  /// PIN/pattern/password (used for account recovery).
  Future<bool> authenticate({
    required String localizedReason,
    bool biometricOnly = true,
  }) async {
    try {
      return await _auth.authenticate(
        localizedReason: localizedReason,
        biometricOnly: biometricOnly,
      );
    } catch (_) {
      return false;
    }
  }
}
