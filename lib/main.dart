import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:applock/application/app.dart';
import 'package:applock/application/dependency_injection/dependency_injection.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/service/app_lock/app_lock_service.dart';
import 'package:applock/utility/enumeration/device_type.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Future.wait([
    dotenv.load(fileName: '.env'),
    configureDependencies(),
    _configureDeviceSettings(),
  ]);

  // Init foreground task service
  GetIt.instance<AppLockService>().initService();

  runApp(const MyApp());
}

Future<void> _configureDeviceSettings() async {
  if (DeviceType.isMobile) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColorsPalette.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }
}
