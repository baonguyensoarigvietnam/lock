import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@lazySingleton
class PermissionService {
  /// Check whether the overlay ("draw over other apps") permission is granted
  Future<bool> isOverlayPermissionGranted() async {
    if (!Platform.isAndroid) return true;
    return Permission.systemAlertWindow.isGranted;
  }

  /// Request overlay permission (opens system setting on Android)
  Future<bool> requestOverlayPermission() async {
    if (!Platform.isAndroid) return true;
    final status = await Permission.systemAlertWindow.request();
    return status.isGranted;
  }

  /// Check whether notification permission is granted
  Future<bool> isNotificationPermissionGranted() async {
    return Permission.notification.isGranted;
  }

  /// Request notification permission
  Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  /// Check whether battery optimization is ignored
  Future<bool> isBatteryOptimizationIgnored() async {
    if (!Platform.isAndroid) return true;
    return Permission.ignoreBatteryOptimizations.isGranted;
  }

  /// Request ignore battery optimizations
  Future<bool> requestIgnoreBatteryOptimization() async {
    if (!Platform.isAndroid) return true;
    final status = await Permission.ignoreBatteryOptimizations.request();
    return status.isGranted;
  }

  /// Check whether photos & videos permission is granted
  Future<bool> isPhotosPermissionGranted() async {
    if (Platform.isAndroid) {
      final photos = await Permission.photos.isGranted;
      final storage = await Permission.storage.isGranted;
      return photos || storage;
    }
    return Permission.photos.isGranted;
  }

  /// Request photos & videos permission
  Future<bool> requestPhotosPermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.photos.request();
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      return status.isGranted;
    }
    final status = await Permission.photos.request();
    return status.isGranted;
  }

  /// Check whether camera permission is granted
  Future<bool> isCameraPermissionGranted() async {
    return Permission.camera.isGranted;
  }

  /// Request camera permission
  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  /// Check whether usage access permission is granted (mocked on non-Android)
  Future<bool> isUsageAccessGranted() async {
    if (!Platform.isAndroid) return true;
    // On Android, usage access requires special settings
    return false;
  }

  /// Request usage access by opening app/system settings
  Future<bool> requestUsageAccess() async {
    return openAppSettings();
  }

  /// Opens app settings
  Future<bool> openAppSettingsPage() async {
    return openAppSettings();
  }
}
