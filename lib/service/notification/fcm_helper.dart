import 'dart:convert';
import 'dart:developer' show log;
import 'dart:io';

import 'package:applock/service/notification/fcm_constant.dart';
import 'package:applock/utility/url_launcher_utility.dart';

/// Helper class for handling FCM notifications
final class FcmHelper {
  const FcmHelper._();

  /// Handle notification data
  static Future<void> handleNotificationData(Map<String, dynamic> data) async {
    try {
      String? url;

      // Get url from data based on platform
      if (Platform.isAndroid && data.containsKey(FcmConstant.urlAndroid)) {
        url = data[FcmConstant.urlAndroid]?.toString();
      } else if (Platform.isIOS && data.containsKey(FcmConstant.urlIos)) {
        url = data[FcmConstant.urlIos]?.toString();
      }

      // Open url if it exists
      if (url != null && url.isNotEmpty) {
        await UrlLauncherUtility.openUrl(url);
      }
    } catch (e) {
      log('Error handling notification data: $e');
    }
  }

  /// Handle notification payload
  static Future<void> handleNotificationPayload(String? payload) async {
    if (payload != null && payload.isNotEmpty) {
      try {
        final decoded = jsonDecode(payload);
        if (decoded is Map<String, dynamic>) {
          await handleNotificationData(decoded);
        }
      } catch (e) {
        log('Error decoding notification payload: $e');
      }
    }
  }
}
