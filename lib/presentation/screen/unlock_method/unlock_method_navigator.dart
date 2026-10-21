import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/presentation/common/base/base_navigator.dart';

class UnlockMethodNavigator extends BaseNavigator {
  const UnlockMethodNavigator({required super.router});

  void goToSetPasscode() => router.push(RouterEndpoint.setPasscode.path);

  void goToSetPattern() => router.push(RouterEndpoint.setPattern.path);

  void goToHome() => router.go(RouterEndpoint.home.path);
}
