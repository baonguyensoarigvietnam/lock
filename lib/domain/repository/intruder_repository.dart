import 'package:applock/domain/model/intruder_alert.dart';
import 'package:applock/utility/helper/result.dart';

abstract class IntruderRepository {
  /// All stored alerts, newest first.
  Future<Result<List<IntruderAlert>>> getAlerts();

  /// Persists a new alert.
  Future<Result<void>> addAlert(IntruderAlert alert);

  /// Deletes an alert and its photo file (if any).
  Future<Result<void>> deleteAlert(String id);

  /// Deletes all alerts and their photo files.
  Future<Result<void>> clearAll();

  /// Copies the alert photo to the app-specific external "AppLockEvidence"
  /// folder and returns the destination path.
  Future<Result<String>> saveEvidence(IntruderAlert alert);

  /// Increments the number of failed unlock attempts recorded today.
  Future<Result<void>> incrementTodayFailedCount();

  /// Number of failed unlock attempts recorded today.
  Future<Result<int>> getTodayFailedCount();

  /// Number of stored alerts.
  Future<Result<int>> getAlertCount();

  /// Whether intruder selfie capture is enabled (default `true`).
  Future<Result<bool>> isIntruderCaptureEnabled();

  Future<Result<void>> setIntruderCaptureEnabled(bool enabled);
}
