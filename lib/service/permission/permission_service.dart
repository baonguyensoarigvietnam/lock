import 'dart:developer';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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

  /// Request ATT with lifecycle-aware delays
  Future<void> requestATT() async {
    final status = await _currentATTStatus;
    if (status != TrackingStatus.notDetermined) return;

    try {
      await AppTrackingTransparency.requestTrackingAuthorization();
    } catch (e) {
      log('ATT Request Error: $e');
    }
  }

  /// Retrieves the current ATT status
  Future<TrackingStatus> get _currentATTStatus async {
    try {
      return await AppTrackingTransparency.trackingAuthorizationStatus;
    } on PlatformException catch (e) {
      log('ATT Error: $e');
    }
    return TrackingStatus.notSupported;
  }

  /// Request Firebase Notification permissions
  Future<NotificationSettings?> requestNotification() async {
    try {
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      return settings;
    } catch (e) {
      log('Firebase Notification Permission Error: $e');
      return null;
    }
  }

  /// Orchestrate permissions sequentially (Notification + ATT on iOS)
  Future<void> requestAllPermissions() async {
    await requestNotification();

    // Adding a slight buffer for the UI to settle
    await Future.delayed(const Duration(milliseconds: 500));

    if (Platform.isIOS) {
      await requestATT();
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
    await requestNotification();
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
