import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/domain/model/lock_config.dart';
import 'package:applock/domain/model/lock_screen_args.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/service/app_lock/app_lock_service.dart';
import 'package:applock/service/app_lock/lock_engine_coordinator.dart';
import 'package:applock/utility/helper/result.dart';

/// Shows the lock screen when:
/// - the native service reports that a protected app was opened, or
/// - App Lock itself comes back to the foreground after a while (or after it
///   sent itself to the background following an external unlock).
@lazySingleton
class AppLockGate {
  final AppLockService _appLockService;
  final AppLockRepository _repository;
  final LockEngineCoordinator _lockEngineCoordinator;

  AppLockGate(
    this._appLockService,
    this._repository,
    this._lockEngineCoordinator,
  );

  /// Short trips to system pages (photo picker, settings, mail app) do not
  /// re-lock App Lock; longer absences do.
  static const Duration selfRelockAfter = Duration(seconds: 30);

  /// Routes where the self lock must never be stacked on top.
  static final Set<String> _unguardedPaths = {
    RouterEndpoint.splash.path,
    RouterEndpoint.onboarding.path,
    RouterEndpoint.unlockMethod.path,
    RouterEndpoint.setPasscode.path,
    RouterEndpoint.setPattern.path,
    RouterEndpoint.enableBiometric.path,
    RouterEndpoint.permissionGuide.path,
    RouterEndpoint.lockScreen.path,
  };

  GoRouter? _router;
  StreamSubscription<LockScreenArgs>? _lockSubscription;
  AppLifecycleListener? _lifecycleListener;
  DateTime? _pausedAt;

  void start(GoRouter router) {
    if (_router != null) return;
    _router = router;
    _appLockService.initService();
    _lockSubscription = _appLockService.lockRequests.listen(_showExternalLock);
    _lifecycleListener = AppLifecycleListener(
      onHide: () => _pausedAt ??= DateTime.now(),
      onShow: _onShow,
    );
    unawaited(_lockEngineCoordinator.syncAll());
  }

  void dispose() {
    _lockSubscription?.cancel();
    _lifecycleListener?.dispose();
    _router = null;
  }

  String? get _currentPath {
    try {
      return _router?.state.uri.path;
    } catch (_) {
      return null;
    }
  }

  void _showExternalLock(LockScreenArgs args) {
    final router = _router;
    if (router == null) return;
    // Splash consumes cold-start requests itself.
    if (_currentPath == RouterEndpoint.splash.path) return;
    _appLockService.consumeSelfUnlockRequest();
    if (_currentPath == RouterEndpoint.lockScreen.path) {
      router.pushReplacement(RouterEndpoint.lockScreen.path, extra: args);
    } else {
      router.push(RouterEndpoint.lockScreen.path, extra: args);
    }
  }

  Future<void> _onShow() async {
    final pausedAt = _pausedAt;
    _pausedAt = null;
    final forced = _appLockService.consumeSelfUnlockRequest();
    final longAbsence = pausedAt != null &&
        DateTime.now().difference(pausedAt) >= selfRelockAfter;

    // Keep the native engine alive / in sync after returning from settings.
    unawaited(_lockEngineCoordinator.syncAll());

    if (!forced && !longAbsence) return;
    // Give a pending external lock request time to arrive first.
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (!await _shouldSelfLock()) return;
    _router?.push(
      RouterEndpoint.lockScreen.path,
      extra: const LockScreenArgs(mode: LockScreenMode.selfUnlock),
    );
  }

  Future<bool> _shouldSelfLock() async {
    final path = _currentPath;
    if (path == null || _unguardedPaths.contains(path)) return false;
    final onboarded = await _repository.isOnboardingCompleted();
    if (onboarded is! Success<bool> || !onboarded.data) return false;
    final config = await _repository.getLockConfig();
    return config is Success<LockConfig> &&
        (config.data.hasPinCode || config.data.hasPattern);
  }
}
