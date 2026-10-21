import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:applock/application/dependency_injection/dependency_injection.config.dart';
import 'package:applock/application/router/app_router.dart';
import 'package:applock/application/view_model/global_view_model.dart';

@InjectableInit()
Future<void> configureDependencies() => GetIt.instance.init();

@module
abstract class GlobalDependencyInjectionModule {
  @singleton
  GoRouter router(GlobalViewModel globalViewModel) =>
      AppRouter(globalViewModel).router;

  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @preResolve
  Future<PackageInfo> get packageInfo => PackageInfo.fromPlatform();
}
