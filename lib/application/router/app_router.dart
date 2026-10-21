import 'package:go_router/go_router.dart';
import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/application/router/router_key.dart';
import 'package:applock/application/view_model/global_view_model.dart';
import 'package:applock/presentation/screen/enable_biometric/enable_biometric_page.dart';
import 'package:applock/presentation/screen/main/main_page.dart';
import 'package:applock/presentation/screen/lock_screen/lock_screen_page.dart';
import 'package:applock/presentation/screen/onboarding/onboarding_page.dart';
import 'package:applock/presentation/screen/paywall/paywall_page.dart';
import 'package:applock/presentation/screen/permission_guide/permission_guide_page.dart';
import 'package:applock/presentation/screen/set_passcode/set_passcode_page.dart';
import 'package:applock/presentation/screen/set_pattern/set_pattern_page.dart';
import 'package:applock/presentation/screen/splash/splash_page.dart';
import 'package:applock/presentation/screen/unlock_method/unlock_method_page.dart';

final class AppRouter {
  AppRouter(this._globalViewModel);

  // ignore: unused_field
  final GlobalViewModel _globalViewModel;

  late final GoRouter router = GoRouter(
    initialLocation: RouterEndpoint.splash.path,
    navigatorKey: RouterKey.rootNavigatorKey,
    routes: <RouteBase>[
      GoRoute(
        name: RouterEndpoint.splash.name,
        path: RouterEndpoint.splash.path,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        name: RouterEndpoint.onboarding.name,
        path: RouterEndpoint.onboarding.path,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        name: RouterEndpoint.unlockMethod.name,
        path: RouterEndpoint.unlockMethod.path,
        builder: (context, state) => const UnlockMethodPage(),
      ),
      GoRoute(
        name: RouterEndpoint.paywall.name,
        path: RouterEndpoint.paywall.path,
        builder: (context, state) => const PaywallPage(),
      ),
      GoRoute(
        name: RouterEndpoint.home.name,
        path: RouterEndpoint.home.path,
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        name: RouterEndpoint.main.name,
        path: RouterEndpoint.main.path,
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        name: RouterEndpoint.setPasscode.name,
        path: RouterEndpoint.setPasscode.path,
        builder: (context, state) => const SetPasscodePage(),
      ),
      GoRoute(
        name: RouterEndpoint.setPattern.name,
        path: RouterEndpoint.setPattern.path,
        builder: (context, state) => const SetPatternPage(),
      ),
      GoRoute(
        name: RouterEndpoint.enableBiometric.name,
        path: RouterEndpoint.enableBiometric.path,
        builder: (context, state) => const EnableBiometricPage(),
      ),
      GoRoute(
        name: RouterEndpoint.lockScreen.name,
        path: RouterEndpoint.lockScreen.path,
        builder: (context, state) {
          final appName = state.extra as String?;
          return LockScreenPage(appName: appName);
        },
      ),
      GoRoute(
        name: RouterEndpoint.permissionGuide.name,
        path: RouterEndpoint.permissionGuide.path,
        builder: (context, state) => const PermissionGuidePage(),
      ),
    ],
  );
}
