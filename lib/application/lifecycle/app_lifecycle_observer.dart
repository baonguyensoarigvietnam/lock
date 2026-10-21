import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/application/router/router_key.dart';

/// Monitors app lifecycle events and broadcasts [AppLifecycleState].
@lazySingleton
class AppLifecycleObserver with WidgetsBindingObserver {
  final _lifecycleController = StreamController<AppLifecycleState>.broadcast();
  Stream<AppLifecycleState> get onLifecycleChange =>
      _lifecycleController.stream;

  bool _isObserving = false;
  bool _isDisposed = false;

  /// Flag used to block App Open Ads in specific flows (e.g., interstitial ad,
  /// lock screen, payment).
  bool _isFlowLocked = false;

  static final Set<String> _adBlockedRouteNames = {
    RouterEndpoint.splash.name,
    RouterEndpoint.onboarding.name,
    RouterEndpoint.unlockMethod.name,
    RouterEndpoint.setPasscode.name,
    RouterEndpoint.setPattern.name,
    RouterEndpoint.enableBiometric.name,
    RouterEndpoint.permissionGuide.name,
    RouterEndpoint.lockScreen.name,
  };

  void lockAdTrigger() => _isFlowLocked = true;
  void unlockAdTrigger() => _isFlowLocked = false;

  /// Checks if App Open Ad should be shown on resume (not locked, not in dialog,
  /// and not on LockScreen or onboarding routes).
  bool get canTriggerAdOnResume {
    if (_isFlowLocked) return false;

    bool isBlocked = false;
    RouterKey.rootNavigatorKey.currentState?.popUntil((route) {
      if (route is DialogRoute) {
        isBlocked = true;
      }
      final routeName = route.settings.name;
      if (routeName != null && _adBlockedRouteNames.contains(routeName)) {
        isBlocked = true;
      }
      return true;
    });
    return !isBlocked;
  }

  void startObserving() {
    if (_isObserving) return;
    WidgetsBinding.instance.addObserver(this);
    _isObserving = true;
  }

  void stopObserving() {
    if (!_isObserving) return;
    WidgetsBinding.instance.removeObserver(this);
    _isObserving = false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _lifecycleController.add(state);
  }

  void dispose() {
    if (_isDisposed) return;
    _isDisposed = true;
    stopObserving();
    _lifecycleController.close();
  }
}
