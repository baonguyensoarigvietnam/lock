import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:applock/domain/model/lock_screen_args.dart';
import 'package:applock/utility/enumeration/auto_lock_delay.dart';

/// Bridge to the native Android lock engine (LockMonitorService).
@lazySingleton
class AppLockService {
  static const MethodChannel _channel =
      MethodChannel('com.example.applock/lock');

  final StreamController<LockScreenArgs> _lockRequests =
      StreamController<LockScreenArgs>.broadcast();

  bool _initialized = false;
  bool _selfUnlockRequired = false;

  /// True once App Lock sent itself to the background on purpose (after an
  /// external unlock); the next resume must ask for the PIN again.
  bool consumeSelfUnlockRequest() {
    final required = _selfUnlockRequired;
    _selfUnlockRequired = false;
    return required;
  }

  /// Emits whenever a protected app is opened while App Lock is running.
  Stream<LockScreenArgs> get lockRequests => _lockRequests.stream;

  bool get _isAndroid => Platform.isAndroid;

  void initService() {
    if (_initialized || !_isAndroid) return;
    _initialized = true;
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onLockRequested' && call.arguments is Map) {
        _lockRequests.add(LockScreenArgs.fromMap(call.arguments as Map));
      }
      return null;
    });
  }

  /// Returns the lock request that cold-started the app, if any.
  Future<LockScreenArgs?> consumePendingLock() async {
    if (!_isAndroid) return null;
    final result = await _invoke<Map<dynamic, dynamic>>('consumePendingLock');
    return result == null ? null : LockScreenArgs.fromMap(result);
  }

  Future<bool> startService() async {
    if (!_isAndroid) return true;
    return await _invoke<bool>('startService') ?? false;
  }

  Future<bool> stopService() async {
    if (!_isAndroid) return true;
    return await _invoke<bool>('stopService') ?? false;
  }

  Future<bool> isServiceRunning() async {
    if (!_isAndroid) return false;
    return await _invoke<bool>('isServiceRunning') ?? false;
  }

  Future<void> syncLockedPackages(Set<String> packages) async {
    if (!_isAndroid) return;
    await _invoke<bool>('setLockedPackages', packages.toList());
  }

  Future<void> syncRelockPolicy(AutoLockDelay delay) async {
    if (!_isAndroid) return;
    await _invoke<bool>('setRelockPolicy', {
      'delayMs': delay.delayMs,
      'onScreenOff': delay.relockOnScreenOff,
    });
  }

  /// Tells the native service the user unlocked [packageName].
  Future<void> markUnlocked(String packageName) async {
    if (!_isAndroid) return;
    await _invoke<bool>('markUnlocked', packageName);
  }

  /// Sends App Lock to the background so the unlocked app is visible again.
  Future<void> moveToBack() async {
    if (!_isAndroid) return;
    _selfUnlockRequired = true;
    await _invoke<bool>('moveToBack');
  }

  /// Leaves a protected app without unlocking it.
  Future<void> goHome() async {
    if (!_isAndroid) return;
    _selfUnlockRequired = true;
    await _invoke<bool>('goHome');
  }

  /// Apps with a launcher entry (raw maps: packageName, name, versionName,
  /// isSystem, icon). Empty on non-Android platforms.
  Future<List<Map<dynamic, dynamic>>> getLaunchableApps() async {
    if (!_isAndroid) return const [];
    final result = await _invoke<List<dynamic>>('getLaunchableApps');
    return result?.whereType<Map<dynamic, dynamic>>().toList() ?? const [];
  }

  Future<T?> _invoke<T>(String method, [Object? arguments]) async {
    try {
      return await _channel.invokeMethod<T>(method, arguments);
    } on PlatformException {
      return null;
    } on MissingPluginException {
      return null;
    }
  }
}
