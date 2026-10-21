import 'dart:io';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppLockService {
  void initService() {
    if (!Platform.isAndroid) return;

    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'applock_foreground_channel',
        channelName: 'AppLock Service',
        channelDescription: 'Giữ dịch vụ bảo vệ khoá ứng dụng hoạt động ngầm',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: false,
        playSound: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(5000),
        autoRunOnBoot: true,
        autoRunOnMyPackageReplaced: true,
        allowWakeLock: true,
        allowWifiLock: false,
      ),
    );
  }

  Future<bool> startService() async {
    if (!Platform.isAndroid) return true;

    final isRunning = await FlutterForegroundTask.isRunningService;
    if (isRunning) return true;

    final result = await FlutterForegroundTask.startService(
      serviceId: 256,
      notificationTitle: 'AppLock đang hoạt động',
      notificationText: 'Bảo vệ các ứng dụng đã chọn',
    );
    return result is ServiceRequestSuccess;
  }

  Future<bool> stopService() async {
    if (!Platform.isAndroid) return true;
    final result = await FlutterForegroundTask.stopService();
    return result is ServiceRequestSuccess;
  }

  Future<bool> isServiceRunning() async {
    if (!Platform.isAndroid) return false;
    return FlutterForegroundTask.isRunningService;
  }
}
