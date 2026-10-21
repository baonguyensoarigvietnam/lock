import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:applock/domain/model/app_lock_item.dart';
import 'package:applock/domain/model/lock_config.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/local/data_source/app_lock_local_data_source.dart';
import 'package:applock/utility/helper/result.dart';

@LazySingleton(as: AppLockRepository)
class AppLockRepositoryImpl implements AppLockRepository {
  final AppLockLocalDataSource _localDataSource;

  AppLockRepositoryImpl(this._localDataSource);

  @override
  Future<Result<List<AppLockItem>>> getInstalledApps({
    bool includeSystemApps = false,
  }) async {
    try {
      final lockedSet = _localDataSource.getLockedPackages();

      if (!Platform.isAndroid) {
        // Mock data for previewing UI on non-Android platforms (iOS/Simulator/macOS)
        final mockApps = [
          AppLockItem(
            packageName: 'com.facebook.katana',
            appName: 'Facebook',
            isLocked: lockedSet.contains('com.facebook.katana'),
          ),
          AppLockItem(
            packageName: 'com.zing.zalo',
            appName: 'Zalo',
            isLocked: lockedSet.contains('com.zing.zalo'),
          ),
          AppLockItem(
            packageName: 'com.facebook.orca',
            appName: 'Messenger',
            isLocked: lockedSet.contains('com.facebook.orca'),
          ),
          AppLockItem(
            packageName: 'com.google.android.youtube',
            appName: 'YouTube',
            isLocked: lockedSet.contains('com.google.android.youtube'),
          ),
          AppLockItem(
            packageName: 'com.instagram.android',
            appName: 'Instagram',
            isLocked: lockedSet.contains('com.instagram.android'),
          ),
          AppLockItem(
            packageName: 'com.google.android.gm',
            appName: 'Gmail',
            isLocked: lockedSet.contains('com.google.android.gm'),
          ),
          AppLockItem(
            packageName: 'com.zhiliaoapp.musically',
            appName: 'TikTok',
            isLocked: lockedSet.contains('com.zhiliaoapp.musically'),
          ),
          AppLockItem(
            packageName: 'com.android.chrome',
            appName: 'Google Chrome',
            isLocked: lockedSet.contains('com.android.chrome'),
          ),
        ];
        return Result.success(mockApps);
      }

      final excludeSystem = !includeSystemApps;
      final rawApps = await InstalledApps.getInstalledApps(excludeSystem, true);

      final items = rawApps.map((app) {
        return AppLockItem(
          packageName: app.packageName,
          appName: app.name,
          versionName: app.versionName,
          icon: app.icon,
          isLocked: lockedSet.contains(app.packageName),
        );
      }).toList();

      // Sort alphabetically by appName
      items.sort((a, b) => a.appName.toLowerCase().compareTo(b.appName.toLowerCase()));

      return Result.success(items);
    } catch (e) {
      return Result.error(e);
    }
  }

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
      final bio = _localDataSource.isBiometricEnabled();
      final service = _localDataSource.isServiceActive();
      return Result.success(
        LockConfig(
          pinCode: pin,
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
}
