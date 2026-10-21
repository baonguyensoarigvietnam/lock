import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/presentation/common/base/base_navigator.dart';

class HomeNavigator extends BaseNavigator {
  const HomeNavigator({required super.router});

  void goToPaywall() => router.push(RouterEndpoint.paywall.path);

  void goToSetPasscode() => router.push(RouterEndpoint.setPasscode.path);

  void goToLockScreen() => router.push(RouterEndpoint.lockScreen.path);

  void goToPermissionGuide() => router.push(RouterEndpoint.permissionGuide.path);
}
