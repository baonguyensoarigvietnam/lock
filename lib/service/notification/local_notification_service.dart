import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:applock/service/notification/fcm_constant.dart';
import 'package:applock/service/notification/fcm_helper.dart';

/// Top-level background notification handler
@pragma('vm:entry-point')
void _notificationTapBackground(NotificationResponse response) {
  log('Background notification has been tapped: ${response.payload}');
  FcmHelper.handleNotificationPayload(response.payload);
}

/// Service for handling local notifications
class LocalNotificationsService {
  /// Private constructor for singleton pattern
  LocalNotificationsService._internal();

  /// Singleton instance
  static final LocalNotificationsService _instance =
      LocalNotificationsService._internal();

  /// Factory constructor to return singleton instance
  factory LocalNotificationsService.instance() => _instance;

  /// Main plugin instance for handling notifications
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  /// Android notification channel configuration
  final _androidChannel = const AndroidNotificationChannel(
    FcmConstant.channelID,
    FcmConstant.channelName,
    description: FcmConstant.channelDescription,
    importance: Importance.max,
  );

  /// Flag to track initialization status
  bool _isFlutterLocalNotificationInitialized = false;

  /// Initializes the local notifications plugin for Android and iOS.
  Future<void> init() async {
    // Check if already initialized to prevent redundant setup
    if (_isFlutterLocalNotificationInitialized) {
      return;
    }

    // Create plugin instance
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Combine platform-specific settings
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings(FcmConstant.icon),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        notificationCategories: [],
      ),
    );

    // Initialize plugin with settings and callback for notification taps
    await _flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // Handle notification tap in foreground
        log('Foreground notification has been tapped: ${response.payload}');
        await FcmHelper.handleNotificationPayload(response.payload);
      },
      onDidReceiveBackgroundNotificationResponse: _notificationTapBackground,
    );

    // Create Android notification channel
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_androidChannel);

    // Mark initialization as complete
    _isFlutterLocalNotificationInitialized = true;
  }

  /// Show a local notification with the given title, body, and payload.
  Future<void> showNotification(
    String? title,
    String? body,
    String? payload,
  ) async {
    // Combine platform-specific details
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        FcmConstant.channelID,
        FcmConstant.channelName,
        channelDescription: FcmConstant.channelDescription,
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        interruptionLevel: InterruptionLevel.active,
      ),
    );

    // Display the notification
    await _flutterLocalNotificationsPlugin.show(
      id: DateTime.now().millisecond,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
      payload: payload,
    );
  }
}
