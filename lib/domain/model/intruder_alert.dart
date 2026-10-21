import 'package:applock/utility/enumeration/intruder_unlock_method.dart';

/// A single intruder alert (a burst of consecutive failed unlock attempts).
class IntruderAlert {
  const IntruderAlert({
    required this.id,
    required this.createdAt,
    required this.method,
    required this.failedCount,
    this.appName,
    this.photoPath,
  });

  final String id;
  final DateTime createdAt;

  /// Name of the locked app the intruder tried to open.
  /// `null` means the main App Lock unlock screen.
  final String? appName;
  final IntruderUnlockMethod method;
  final int failedCount;

  /// Absolute path of the captured photo, `null` when no photo was taken.
  final String? photoPath;

  bool get hasPhoto => photoPath != null && photoPath!.isNotEmpty;
}
