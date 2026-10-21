import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/presentation/common/base/base_navigator.dart';

class OnboardingNavigator extends BaseNavigator {
  const OnboardingNavigator({required super.router});

  void goToUnlockMethod() => router.go(RouterEndpoint.unlockMethod.path);

  void goToSetPasscode() => router.go(RouterEndpoint.setPasscode.path);
}
