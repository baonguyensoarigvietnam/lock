import 'dart:convert';
import 'dart:developer' show log;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:applock/service/firebase/firebase_options.dart';
import 'package:applock/service/notification/fcm_helper.dart';
import 'package:applock/service/notification/local_notification_service.dart';

/// Top-level handler for message Background / Terminated
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling a background message: ${message.messageId}');

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (_) {}

  final notificationData = message.notification;
  if (notificationData != null) {
    final localNotificationsService = LocalNotificationsService.instance();

    await localNotificationsService.init();

    await localNotificationsService.showNotification(
      notificationData.title,
      notificationData.body,
      jsonEncode(message.data),
    );
  }
}

@lazySingleton
/// Service for handling Firebase Cloud Messaging
class FcmService {
  FcmService();

  /// Stream of FCM token refreshes
  Stream<String> get onTokenRefresh {
    try {
      return FirebaseMessaging.instance.onTokenRefresh;
    } catch (_) {
      return const Stream.empty();
    }
  }

  /// Retrieves the current FCM token for the device
  Future<String?> getToken() async {
    try {
      return await FirebaseMessaging.instance.getToken();
    } catch (e) {
      log('Error getting FCM token: $e');
      return null;
    }
  }

  // Reference to local notifications service for displaying notifications
  LocalNotificationsService? _localNotificationsService;

  /// Initialize Firebase Messaging and sets up all message listeners
  Future<void> init() async {
    try {
      // Init local notifications service
      _localNotificationsService = LocalNotificationsService.instance();
      await _localNotificationsService?.init();

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );

      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // Listen for messages when the app is in foreground
      FirebaseMessaging.onMessage.listen(_onForegroundMessage);

      // Listen for notification taps when the app is in background but not terminated
      FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);

      // Check for initial message that opened the app from terminated state
      final initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        _onMessageOpenedApp(initialMessage);
      }
    } catch (e) {
      log('Error initializing FcmService: $e');
    }
  }

  /// Handles messages received while the app is in the foreground
  void _onForegroundMessage(RemoteMessage message) {
    log(
      'Foreground message received: ${message.data} ${message.notification?.apple} ${message.notification?.title}',
    );

    if (defaultTargetPlatform == TargetPlatform.android) {
      final notificationData = message.notification;
      if (notificationData != null) {
        // Display a local notification using the service
        _localNotificationsService?.showNotification(
          notificationData.title,
          notificationData.body,
          jsonEncode(message.data),
        );
      }
    }
  }

  /// Handles notification taps when app is opened from the background or terminated state
  void _onMessageOpenedApp(RemoteMessage message) {
    log('Notification caused the app to open: ${message.data}');
    FcmHelper.handleNotificationData(message.data);
  }
}
