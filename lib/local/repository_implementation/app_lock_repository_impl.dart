import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:applock/domain/model/app_lock_item.dart';
import 'package:applock/domain/model/lock_config.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/local/data_source/app_lock_local_data_source.dart';
import 'package:applock/service/app_lock/app_lock_service.dart';
import 'package:applock/utility/enumeration/app_category.dart';
import 'package:applock/utility/enumeration/auto_lock_delay.dart';
import 'package:applock/utility/enumeration/lock_screen_theme.dart';
import 'package:applock/utility/helper/result.dart';

@LazySingleton(as: AppLockRepository)
class AppLockRepositoryImpl implements AppLockRepository {
  final AppLockLocalDataSource _localDataSource;
  final AppLockService _appLockService;

  AppLockRepositoryImpl(this._localDataSource, this._appLockService);

  @override
  Future<Result<List<AppLockItem>>> getInstalledApps({
    bool includeSystemApps = false,
  }) async {
    try {
      final lockedSet = _localDataSource.getLockedPackages();
      // Only launchable apps are listed (system apps such as Gallery or
      // Messages included); no QUERY_ALL_PACKAGES permission is required.
      final rawApps = await _appLockService.getLaunchableApps();

      final items = rawApps.map((raw) {
        final packageName = raw['packageName'] as String? ?? '';
        final name = raw['name'] as String? ?? packageName;
        final isSystem = raw['isSystem'] as bool? ?? false;
        return AppLockItem(
          packageName: packageName,
          appName: name,
          versionName: raw['versionName'] as String?,
          icon: raw['icon'] as Uint8List?,
          isSystem: isSystem,
          category: AppCategory.infer(
            packageName: packageName,
            appName: name,
            isSystem: isSystem,
          ),
          isLocked: lockedSet.contains(packageName),
        );
      }).where((item) {
        return item.packageName.isNotEmpty &&
            (includeSystemApps || !_hiddenPackages.contains(item.packageName));
      }).toList();

      items.sort(
        (a, b) => a.appName.toLowerCase().compareTo(b.appName.toLowerCase()),
      );

      return Result.success(items);
    } catch (e) {
      return Result.error(e);
    }
  }

  /// Launcher entries that make no sense to lock.
  static const Set<String> _hiddenPackages = {
    'com.android.stk',
  };

  @override
  Future<Result<Set<String>>> getLockedPackageNames() async {
    try {
      final locked = _localDataSource.getLockedPackages();
      return Result.success(locked);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> toggleLockApp(String packageName, bool lock) async {
    try {
      final locked = _localDataSource.getLockedPackages();
      if (lock) {
        locked.add(packageName);
      } else {
        locked.remove(packageName);
      }
      await _localDataSource.setLockedPackages(locked);
      return const Result.success(null);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<LockConfig>> getLockConfig() async {
    try {
      final pin = _localDataSource.getPinCode();
      final pattern = _localDataSource.getPattern();
      final bio = _localDataSource.isBiometricEnabled();
      final service = _localDataSource.isServiceActive();
      return Result.success(
        LockConfig(
          pinCode: pin,
          pattern: pattern,
          isBiometricEnabled: bio,
          isServiceActive: service,
        ),
      );
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> savePinCode(String pin) async {
    try {
      await _localDataSource.setPinCode(pin);
      return const Result.success(null);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> savePattern(String pattern) async {
    try {
      await _localDataSource.setPattern(pattern);
      return const Result.success(null);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> setBiometricEnabled(bool enabled) async {
    try {
      await _localDataSource.setBiometricEnabled(enabled);
      return const Result.success(null);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> setServiceActive(bool active) async {
    try {
      await _localDataSource.setServiceActive(active);
      return const Result.success(null);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<bool>> isOnboardingCompleted() async {
    try {
      final completed = _localDataSource.isOnboardingCompleted();
      return Result.success(completed);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> setOnboardingCompleted(bool completed) async {
    try {
      await _localDataSource.setOnboardingCompleted(completed);
      return const Result.success(null);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<String>> getLanguageCode() async {
    try {
      final code = _localDataSource.getLanguageCode();
      return Result.success(code);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> saveLanguageCode(String code) async {
    try {
      await _localDataSource.setLanguageCode(code);
      return const Result.success(null);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<AutoLockDelay>> getAutoLockDelay() async {
    try {
      return Result.success(
        AutoLockDelay.fromStorageKey(_localDataSource.getAutoLockDelay()),
      );
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> saveAutoLockDelay(AutoLockDelay delay) async {
    try {
      await _localDataSource.setAutoLockDelay(delay.storageKey);
      return const Result.success(null);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<LockScreenTheme>> getLockScreenTheme() async {
    try {
      return Result.success(
        LockScreenTheme.fromStorageKey(_localDataSource.getLockScreenTheme()),
      );
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> saveLockScreenTheme(LockScreenTheme theme) async {
    try {
      await _localDataSource.setLockScreenTheme(theme.storageKey);
      return const Result.success(null);
    } catch (e) {
      return Result.error(e);
    }
  }
}
