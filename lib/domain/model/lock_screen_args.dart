/// Where the lock screen was opened from.
enum LockScreenMode {
  /// A protected app was opened; launched by the native lock service.
  external,

  /// Protects the App Lock app itself when it is opened.
  selfUnlock,

  /// In-app preview (e.g. tapping an app in the Apps list).
  preview,
}

/// Arguments passed to the lock screen route.
class LockScreenArgs {
  final String? packageName;
  final String? appName;
  final LockScreenMode mode;

  const LockScreenArgs({
    this.packageName,
    this.appName,
    this.mode = LockScreenMode.preview,
  });

  factory LockScreenArgs.fromMap(Map<dynamic, dynamic> map) {
    return LockScreenArgs(
      packageName: map['packageName'] as String?,
      appName: map['appName'] as String?,
      mode: LockScreenMode.external,
    );
  }
}
