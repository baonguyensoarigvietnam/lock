import 'dart:io';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

/// Runtime permission helper.
///
/// Special-access permissions (usage access, overlay, battery optimization)
/// are checked natively and requested by opening the matching system settings
/// page; the result must be re-checked when the app resumes.
@lazySingleton
class PermissionService {
  static const MethodChannel _channel =
      MethodChannel('com.example.applock/lock');

  Future<bool> _nativeBool(String method, {bool fallback = false}) async {
    try {
      return await _channel.invokeMethod<bool>(method) ?? fallback;
    } on PlatformException {
      return fallback;
    } on MissingPluginException {
      return fallback;
    }
  }

  /// Whether "Display over other apps" is granted (needed to show the lock
  /// screen on top of a protected app).
  Future<bool> isOverlayPermissionGranted() async {
    if (!Platform.isAndroid) return true;
    return _nativeBool('canDrawOverlays');
  }

  /// Opens the overlay settings page. Re-check on resume.
  Future<bool> requestOverlayPermission() async {
    if (!Platform.isAndroid) return true;
    await _nativeBool('openOverlaySettings');
    return isOverlayPermissionGranted();
  }

  Future<bool> isNotificationPermissionGranted() async {
    return Permission.notification.isGranted;
  }

  Future<bool> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  Future<bool> isBatteryOptimizationIgnored() async {
    if (!Platform.isAndroid) return true;
    return _nativeBool('isIgnoringBatteryOptimizations', fallback: true);
  }

  /// Opens the system battery optimization list (no restricted permission
  /// needed). Re-check on resume.
  Future<bool> requestIgnoreBatteryOptimization() async {
    if (!Platform.isAndroid) return true;
    await _nativeBool('openBatteryOptimizationSettings');
    return isBatteryOptimizationIgnored();
  }

  Future<bool> isCameraPermissionGranted() async {
    return Permission.camera.isGranted;
  }

  Future<bool> isCameraPermissionPermanentlyDenied() async {
    return Permission.camera.isPermanentlyDenied;
  }

  Future<bool> requestCameraPermission() async {
    final status = await Permission.camera.request();
    return status.isGranted;
  }

  /// Whether Usage Access is granted (required to detect the foreground app).
  Future<bool> isUsageAccessGranted() async {
    if (!Platform.isAndroid) return true;
    return _nativeBool('hasUsageAccess');
  }

  /// Opens the Usage Access settings page. Re-check on resume.
  Future<bool> requestUsageAccess() async {
    if (!Platform.isAndroid) return true;
    await _nativeBool('openUsageAccessSettings');
    return isUsageAccessGranted();
  }

  Future<bool> openAppSettingsPage() async {
    return openAppSettings();
  }
}
