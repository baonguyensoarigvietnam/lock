import 'package:applock/utility/helper/result.dart';

abstract class AppTrackingRepository {
  /// Send install event with optional FCM token.
  Future<Result<void>> sendInstallEvent({String? fcmToken});
}
