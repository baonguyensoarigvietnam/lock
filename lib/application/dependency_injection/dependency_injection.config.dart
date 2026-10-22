// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:applock/application/dependency_injection/dependency_injection.dart'
    as _i1035;
import 'package:applock/application/lifecycle/app_lifecycle_observer.dart'
    as _i340;
import 'package:applock/application/view_model/global_view_model.dart' as _i641;
import 'package:applock/domain/repository/ad_repository.dart' as _i620;
import 'package:applock/domain/repository/app_lock_repository.dart' as _i128;
import 'package:applock/domain/repository/app_tracking_repository.dart' as _i701;
import 'package:applock/domain/repository/intruder_repository.dart' as _i594;
import 'package:applock/domain/repository/vault_repository.dart' as _i572;
import 'package:applock/local/data_source/app_lock_local_data_source.dart'
    as _i178;
import 'package:applock/local/data_source/vault_local_data_source.dart'
    as _i444;
import 'package:applock/local/repository_implementation/app_lock_repository_impl.dart'
    as _i876;
import 'package:applock/local/repository_implementation/intruder_repository_impl.dart'
    as _i81;
import 'package:applock/local/repository_implementation/vault_repository_impl.dart'
    as _i326;
import 'package:applock/network/configuration/dio_configuration.dart' as _i283;
import 'package:applock/network/data_source/ad_remote_data_source.dart'
    as _i613;
import 'package:applock/network/data_source/app_tracking_data_source.dart'
    as _i702;
import 'package:applock/network/repository_implementation/ad_repository_impl.dart'
    as _i845;
import 'package:applock/network/repository_implementation/app_tracking_repository_impl.dart'
    as _i703;
import 'package:applock/presentation/screen/alerts/view_model/alerts_view_model.dart'
    as _i616;
import 'package:applock/presentation/screen/apps/view_model/apps_view_model.dart'
    as _i151;
import 'package:applock/presentation/screen/enable_biometric/view_model/enable_biometric_view_model.dart'
    as _i1045;
import 'package:applock/presentation/screen/home/view_model/home_view_model.dart'
    as _i669;
import 'package:applock/presentation/screen/lock_screen/view_model/lock_screen_view_model.dart'
    as _i693;
import 'package:applock/presentation/screen/main/view_model/main_view_model.dart'
    as _i543;
import 'package:applock/presentation/screen/onboarding/view_model/onboarding_view_model.dart'
    as _i541;
import 'package:applock/presentation/screen/paywall/view_model/paywall_view_model.dart'
    as _i131;
import 'package:applock/presentation/screen/permission_guide/view_model/permission_guide_view_model.dart'
    as _i345;
import 'package:applock/presentation/screen/set_passcode/view_model/set_passcode_view_model.dart'
    as _i930;
import 'package:applock/presentation/screen/set_pattern/view_model/set_pattern_view_model.dart'
    as _i960;
import 'package:applock/presentation/screen/settings/view_model/settings_view_model.dart'
    as _i879;
import 'package:applock/presentation/screen/splash/view_model/splash_view_model.dart'
    as _i989;
import 'package:applock/presentation/screen/unlock_method/view_model/unlock_method_view_model.dart'
    as _i955;
import 'package:applock/presentation/screen/vault/view_model/vault_view_model.dart'
    as _i488;
import 'package:applock/service/admob/admob_service.dart' as _i182;
import 'package:applock/service/app_lock/app_lock_gate.dart' as _i13;
import 'package:applock/service/app_lock/app_lock_service.dart' as _i270;
import 'package:applock/service/app_lock/biometric_service.dart' as _i189;
import 'package:applock/service/app_lock/lock_engine_coordinator.dart' as _i568;
import 'package:applock/service/intruder/intruder_service.dart' as _i650;
import 'package:applock/service/notification/fcm_service.dart' as _i441;
import 'package:applock/service/permission/permission_service.dart' as _i897;
import 'package:applock/service/purchase/purchase_service.dart' as _i346;
import 'package:applock/service/vault/vault_crypto_service.dart' as _i807;
import 'package:applock/service/vault/vault_media_picker_service.dart' as _i214;
import 'package:applock/service/vault/vault_thumbnail_service.dart' as _i483;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:injectable/injectable.dart' as _i526;
import 'package:package_info_plus/package_info_plus.dart' as _i655;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final globalDependencyInjectionModule = _$GlobalDependencyInjectionModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => globalDependencyInjectionModule.sharedPreferences,
      preResolve: true,
    );
    await gh.factoryAsync<_i655.PackageInfo>(
      () => globalDependencyInjectionModule.packageInfo,
      preResolve: true,
    );
    await gh.factoryAsync<String>(
      () => globalDependencyInjectionModule.deviceID,
      instanceName: 'deviceID',
      preResolve: true,
    );
    gh.factory<_i543.MainViewModel>(() => _i543.MainViewModel());
    gh.factory<_i955.UnlockMethodViewModel>(
      () => _i955.UnlockMethodViewModel(),
    );
    gh.lazySingleton<_i340.AppLifecycleObserver>(
      () => _i340.AppLifecycleObserver(),
    );
    gh.lazySingleton<_i444.VaultLocalDataSource>(
      () => _i444.VaultLocalDataSource(),
    );
    gh.lazySingleton<_i182.AdmobService>(
      () => _i182.AdmobService(),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i441.FcmService>(() => _i441.FcmService());
    gh.lazySingleton<_i270.AppLockService>(() => _i270.AppLockService());
    gh.lazySingleton<_i189.BiometricService>(() => _i189.BiometricService());
    gh.lazySingleton<_i897.PermissionService>(() => _i897.PermissionService());
    gh.lazySingleton<_i807.VaultCryptoService>(
      () => _i807.VaultCryptoService(),
    );
    gh.lazySingleton<_i214.VaultMediaPickerService>(
      () => _i214.VaultMediaPickerService(),
    );
    gh.lazySingleton<_i483.VaultThumbnailService>(
      () => _i483.VaultThumbnailService(),
    );
    gh.lazySingleton<_i572.VaultRepository>(
      () => _i326.VaultRepositoryImpl(
        gh<_i444.VaultLocalDataSource>(),
        gh<_i807.VaultCryptoService>(),
        gh<_i483.VaultThumbnailService>(),
      ),
    );
    gh.lazySingleton<_i178.AppLockLocalDataSource>(
      () => _i178.AppLockLocalDataSource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i346.PurchaseService>(
      () => _i346.PurchaseService(gh<_i460.SharedPreferences>()),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i128.AppLockRepository>(
      () => _i876.AppLockRepositoryImpl(
        gh<_i178.AppLockLocalDataSource>(),
        gh<_i270.AppLockService>(),
      ),
    );
    gh.singleton<_i283.DioConfiguration>(
      () => _i283.DioConfiguration(
        gh<_i655.PackageInfo>(),
        gh<String>(instanceName: 'deviceID'),
      ),
    );
    gh.lazySingleton<_i568.LockEngineCoordinator>(
      () => _i568.LockEngineCoordinator(
        gh<_i128.AppLockRepository>(),
        gh<_i270.AppLockService>(),
        gh<_i897.PermissionService>(),
      ),
    );
    gh.factory<_i989.SplashViewModel>(
      () => _i989.SplashViewModel(
        gh<_i128.AppLockRepository>(),
        gh<_i270.AppLockService>(),
      ),
    );
    gh.factory<_i345.PermissionGuideViewModel>(
      () => _i345.PermissionGuideViewModel(
        gh<_i897.PermissionService>(),
        gh<_i128.AppLockRepository>(),
        gh<_i568.LockEngineCoordinator>(),
      ),
    );
    gh.lazySingleton<_i13.AppLockGate>(
      () => _i13.AppLockGate(
        gh<_i270.AppLockService>(),
        gh<_i128.AppLockRepository>(),
        gh<_i568.LockEngineCoordinator>(),
      ),
    );
    gh.factory<_i879.SettingsViewModel>(
      () => _i879.SettingsViewModel(
        gh<_i128.AppLockRepository>(),
        gh<_i189.BiometricService>(),
        gh<_i568.LockEngineCoordinator>(),
      ),
    );
    gh.lazySingleton<_i594.IntruderRepository>(
      () => _i81.IntruderRepositoryImpl(gh<_i460.SharedPreferences>()),
    );
    gh.factory<_i1045.EnableBiometricViewModel>(
      () => _i1045.EnableBiometricViewModel(
        gh<_i128.AppLockRepository>(),
        gh<_i189.BiometricService>(),
      ),
    );
    gh.factory<_i488.VaultViewModel>(
      () => _i488.VaultViewModel(
        gh<_i572.VaultRepository>(),
        gh<_i214.VaultMediaPickerService>(),
      ),
    );
    gh.singleton<_i361.Dio>(
      () =>
          globalDependencyInjectionModule.hubDio(gh<_i283.DioConfiguration>()),
      instanceName: 'hubDio',
    );
    gh.factory<_i131.PaywallViewModel>(
      () => _i131.PaywallViewModel(gh<_i346.PurchaseService>()),
    );
    gh.lazySingleton<_i650.IntruderService>(
      () => _i650.IntruderService(
        gh<_i594.IntruderRepository>(),
        gh<_i897.PermissionService>(),
      ),
    );
    gh.factory<_i616.AlertsViewModel>(
      () => _i616.AlertsViewModel(
        gh<_i594.IntruderRepository>(),
        gh<_i897.PermissionService>(),
      ),
    );
    gh.factory<_i151.AppsViewModel>(
      () => _i151.AppsViewModel(
        gh<_i128.AppLockRepository>(),
        gh<_i897.PermissionService>(),
        gh<_i568.LockEngineCoordinator>(),
      ),
    );
    gh.factory<_i541.OnboardingViewModel>(
      () => _i541.OnboardingViewModel(
        gh<_i128.AppLockRepository>(),
        gh<_i897.PermissionService>(),
      ),
    );
    gh.factory<_i930.SetPasscodeViewModel>(
      () => _i930.SetPasscodeViewModel(gh<_i128.AppLockRepository>()),
    );
    gh.factory<_i960.SetPatternViewModel>(
      () => _i960.SetPatternViewModel(gh<_i128.AppLockRepository>()),
    );
    gh.factory<_i669.HomeViewModel>(
      () => _i669.HomeViewModel(
        gh<_i128.AppLockRepository>(),
        gh<_i572.VaultRepository>(),
        gh<_i594.IntruderRepository>(),
        gh<_i189.BiometricService>(),
        gh<_i270.AppLockService>(),
      ),
    );
    gh.factory<_i693.LockScreenViewModel>(
      () => _i693.LockScreenViewModel(
        gh<_i128.AppLockRepository>(),
        gh<_i189.BiometricService>(),
        gh<_i270.AppLockService>(),
        gh<_i650.IntruderService>(),
      ),
    );
    gh.lazySingleton<_i613.AdRemoteDataSource>(
      () => _i613.AdRemoteDataSource(gh<_i361.Dio>(instanceName: 'hubDio')),
    );
    gh.lazySingleton<_i620.AdRepository>(
      () => _i845.AdRepositoryImpl(
        remoteDataSource: gh<_i613.AdRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i702.AppTrackingDataSource>(
      () => _i702.AppTrackingDataSource(gh<_i361.Dio>(instanceName: 'hubDio')),
    );
    gh.lazySingleton<_i701.AppTrackingRepository>(
      () => _i703.AppTrackingRepositoryImpl(
        remoteDataSource: gh<_i702.AppTrackingDataSource>(),
      ),
    );
    gh.lazySingleton<_i641.GlobalViewModel>(
      () => _i641.GlobalViewModel(
        gh<_i128.AppLockRepository>(),
        gh<_i897.PermissionService>(),
        gh<_i346.PurchaseService>(),
        gh<_i182.AdmobService>(),
        gh<_i441.FcmService>(),
        gh<_i701.AppTrackingRepository>(),
        gh<_i620.AdRepository>(),
        gh<_i340.AppLifecycleObserver>(),
      ),
    );
    gh.singleton<_i583.GoRouter>(
      () => globalDependencyInjectionModule.router(gh<_i641.GlobalViewModel>()),
    );
    return this;
  }
}

class _$GlobalDependencyInjectionModule
    extends _i1035.GlobalDependencyInjectionModule {}
