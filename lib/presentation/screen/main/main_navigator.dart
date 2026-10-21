import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/presentation/common/base/base_navigator.dart';

class MainNavigator extends BaseNavigator {
  const MainNavigator({required super.router});

  void goToPaywall() => router.push(RouterEndpoint.paywall.path);

  void goToSetPasscode() => router.push(RouterEndpoint.setPasscode.path);

  void goToSetPattern() => router.push(RouterEndpoint.setPattern.path);

  void goToLockScreen({String? appName}) =>
      router.push(RouterEndpoint.lockScreen.path, extra: appName);

  void goToPermissionGuide() => router.push(RouterEndpoint.permissionGuide.path);
}
