import 'dart:typed_data';

import 'package:applock/utility/enumeration/app_category.dart';

/// Represents an installed application that can be protected with AppLock.
class AppLockItem {
  final String packageName;
  final String appName;
  final String? versionName;
  final bool isLocked;
  final bool isSystem;
  final Uint8List? icon;
  final AppCategory category;

  const AppLockItem({
    required this.packageName,
    required this.appName,
    this.versionName,
    this.isLocked = false,
    this.isSystem = false,
    this.icon,
    this.category = AppCategory.other,
  });

  AppLockItem copyWith({
    String? packageName,
    String? appName,
    String? versionName,
    bool? isLocked,
    bool? isSystem,
    Uint8List? icon,
    AppCategory? category,
  }) {
    return AppLockItem(
      packageName: packageName ?? this.packageName,
      appName: appName ?? this.appName,
      versionName: versionName ?? this.versionName,
      isLocked: isLocked ?? this.isLocked,
      isSystem: isSystem ?? this.isSystem,
      icon: icon ?? this.icon,
      category: category ?? this.category,
    );
  }
}
