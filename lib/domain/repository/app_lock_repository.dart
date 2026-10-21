import 'package:applock/domain/model/app_lock_item.dart';
import 'package:applock/domain/model/lock_config.dart';
import 'package:applock/utility/helper/result.dart';

abstract class AppLockRepository {
  Future<Result<List<AppLockItem>>> getInstalledApps({bool includeSystemApps = false});

  Future<Result<Set<String>>> getLockedPackageNames();

  Future<Result<void>> toggleLockApp(String packageName, bool lock);

  Future<Result<LockConfig>> getLockConfig();

  Future<Result<void>> savePinCode(String pin);

  Future<Result<void>> savePattern(String pattern);

  Future<Result<void>> setBiometricEnabled(bool enabled);

  Future<Result<void>> setServiceActive(bool active);

  Future<Result<bool>> isOnboardingCompleted();

  Future<Result<void>> setOnboardingCompleted(bool completed);

  Future<Result<String>> getLanguageCode();

  Future<Result<void>> saveLanguageCode(String code);
}
