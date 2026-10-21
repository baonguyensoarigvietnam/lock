import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/presentation/common/base/base_navigator.dart';

class EnableBiometricNavigator extends BaseNavigator {
  const EnableBiometricNavigator({required super.router});

  void goBack() {
    if (router.canPop()) {
      router.pop();
    }
  }

  void goToPermissionGuide() =>
      router.go(RouterEndpoint.permissionGuide.path);
}
