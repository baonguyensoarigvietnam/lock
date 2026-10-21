import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/domain/model/lock_screen_args.dart';
import 'package:applock/presentation/common/base/base_navigator.dart';

class SplashNavigator extends BaseNavigator {
  const SplashNavigator({required super.router});

  void goToOnboarding() => router.go(RouterEndpoint.onboarding.path);

  void goToHome() => router.go(RouterEndpoint.home.path);

  void goToSetPasscode() => router.go(RouterEndpoint.setPasscode.path);

  void goToLockScreen(LockScreenArgs args) =>
      router.go(RouterEndpoint.lockScreen.path, extra: args);
}
