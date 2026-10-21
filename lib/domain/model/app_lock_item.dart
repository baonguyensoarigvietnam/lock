import 'dart:typed_data';

/// Represents an installed application that can be protected with AppLock.
class AppLockItem {
  final String packageName;
  final String appName;
  final String? versionName;
  final bool isLocked;
  final Uint8List? icon;

  const AppLockItem({
    required this.packageName,
    required this.appName,
    this.versionName,
    this.isLocked = false,
    this.icon,
  });

  AppLockItem copyWith({
    String? packageName,
    String? appName,
    String? versionName,
    bool? isLocked,
    Uint8List? icon,
  }) {
    return AppLockItem(
      packageName: packageName ?? this.packageName,
      appName: appName ?? this.appName,
      versionName: versionName ?? this.versionName,
      isLocked: isLocked ?? this.isLocked,
      icon: icon ?? this.icon,
    );
  }
}
