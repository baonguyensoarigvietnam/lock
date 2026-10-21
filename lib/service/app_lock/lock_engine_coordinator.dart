import 'package:injectable/injectable.dart';
import 'package:applock/domain/model/lock_config.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/service/app_lock/app_lock_service.dart';
import 'package:applock/service/permission/permission_service.dart';
import 'package:applock/utility/enumeration/auto_lock_delay.dart';
import 'package:applock/utility/helper/result.dart';

/// Keeps the native lock engine in sync with the user's configuration.
@lazySingleton
class LockEngineCoordinator {
  final AppLockRepository _repository;
  final AppLockService _appLockService;
  final PermissionService _permissionService;

  LockEngineCoordinator(
    this._repository,
    this._appLockService,
    this._permissionService,
  );

  /// Pushes locked apps + relock policy to native and (re)starts or stops the
  /// service according to the saved "protection active" flag.
  Future<void> syncAll() async {
    final lockedRes = await _repository.getLockedPackageNames();
    final delayRes = await _repository.getAutoLockDelay();
    final configRes = await _repository.getLockConfig();

    final locked = lockedRes is Success<Set<String>>
        ? lockedRes.data
        : <String>{};
    final delay = delayRes is Success<AutoLockDelay>
        ? delayRes.data
        : AutoLockDelay.immediately;

    await _appLockService.syncLockedPackages(locked);
    await _appLockService.syncRelockPolicy(delay);

    final config = configRes is Success<LockConfig> ? configRes.data : null;
    final active = config?.isServiceActive ?? false;
    final hasSecret =
        config != null && (config.hasPinCode || config.hasPattern);

    if (active && hasSecret && locked.isNotEmpty) {
      await ensureRunning();
    } else {
      await _appLockService.stopService();
    }
  }

  /// Starts the service if Usage Access is granted. Returns whether it runs.
  Future<bool> ensureRunning() async {
    if (!await _permissionService.isUsageAccessGranted()) return false;
    if (await _appLockService.isServiceRunning()) return true;
    return _appLockService.startService();
  }

  /// Call after the locked app list changed.
  Future<void> syncLockedPackages() => syncAll();

  Future<void> syncRelockPolicy(AutoLockDelay delay) {
    return _appLockService.syncRelockPolicy(delay);
  }
}
