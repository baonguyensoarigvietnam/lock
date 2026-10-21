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
            packageName: 'com.android.gallery3d',
            appName: 'Gallery',
            category: 'Media',
            lockedSubtitle: 'System App',
            isLocked: lockedSet.contains('com.android.gallery3d'),
          ),
          AppLockItem(
            packageName: 'com.google.android.apps.messaging',
            appName: 'Messages',
            category: 'Communication',
            lockedSubtitle: 'System App',
            isLocked: lockedSet.contains('com.google.android.apps.messaging'),
          ),
          AppLockItem(
            packageName: 'com.google.android.apps.photos',
            appName: 'Photos',
            category: 'Media',
            lockedSubtitle: 'System App',
            isLocked: lockedSet.contains('com.google.android.apps.photos'),
          ),
          AppLockItem(
            packageName: 'com.google.android.gm',
            appName: 'Gmail',
            category: 'Communication',
            lockedSubtitle: 'Third-party App',
            isLocked: lockedSet.contains('com.google.android.gm'),
          ),
          AppLockItem(
            packageName: 'com.instagram.android',
            appName: 'Instagram',
            category: 'Social',
            lockedSubtitle: 'Third-party App',
            isLocked: lockedSet.contains('com.instagram.android'),
          ),
          AppLockItem(
            packageName: 'com.android.banking',
            appName: 'Banking',
            category: 'Finance',
            lockedSubtitle: 'Finance',
            isLocked: lockedSet.contains('com.android.banking'),
          ),
          AppLockItem(
            packageName: 'com.google.android.documentsui',
            appName: 'Files',
            category: 'System',
            lockedSubtitle: 'System App',
            isLocked: lockedSet.contains('com.google.android.documentsui'),
          ),
          AppLockItem(
            packageName: 'com.android.settings',
            appName: 'Settings',
            category: 'System',
            lockedSubtitle: 'System App',
            isLocked: lockedSet.contains('com.android.settings'),
          ),
          AppLockItem(
            packageName: 'com.android.email',
            appName: 'Email',
            category: 'Communication',
            lockedSubtitle: 'Third-party App',
            isLocked: lockedSet.contains('com.android.email'),
          ),
          AppLockItem(
            packageName: 'com.android.contacts',
            appName: 'Contacts',
            category: 'System',
            lockedSubtitle: 'System App',
            isLocked: lockedSet.contains('com.android.contacts'),
          ),
        ];
        return Result.success(mockApps);
      }

      final excludeSystem = !includeSystemApps;
      final rawApps = await InstalledApps.getInstalledApps(excludeSystem, true);

      final items = rawApps.map((app) {
        final category = _inferCategory(app.packageName, app.name);
        return AppLockItem(
          packageName: app.packageName,
          appName: app.name,
          versionName: app.versionName,
          icon: app.icon,
          category: category,
          lockedSubtitle: category == 'System' ? 'System App' : category,
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

  String _inferCategory(String packageName, String appName) {
    final lower = '${packageName.toLowerCase()} ${appName.toLowerCase()}';
    if (lower.contains('photo') ||
        lower.contains('gallery') ||
        lower.contains('video') ||
        lower.contains('youtube') ||
        lower.contains('music')) {
      return 'Media';
    }
    if (lower.contains('message') ||
        lower.contains('messaging') ||
        lower.contains('mail') ||
        lower.contains('zalo') ||
        lower.contains('orca') ||
        lower.contains('whatsapp') ||
        lower.contains('telegram')) {
      return 'Communication';
    }
    if (lower.contains('instagram') ||
        lower.contains('facebook') ||
        lower.contains('tiktok') ||
        lower.contains('social') ||
        lower.contains('twitter')) {
      return 'Social';
    }
    if (lower.contains('bank') ||
        lower.contains('wallet') ||
        lower.contains('pay') ||
        lower.contains('finance')) {
      return 'Finance';
    }
    if (lower.contains('shop') ||
        lower.contains('store') ||
        lower.contains('amazon') ||
        lower.contains('shopee')) {
      return 'Shopping';
    }
    return 'System';
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
