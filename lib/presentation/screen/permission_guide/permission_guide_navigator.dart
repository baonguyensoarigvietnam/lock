import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/presentation/common/base/base_navigator.dart';

class PermissionGuideNavigator extends BaseNavigator {
  const PermissionGuideNavigator({required super.router});

  void goBack() {
    if (router.canPop()) {
      router.pop();
    }
  }

  void goToHome() => router.go(RouterEndpoint.home.path);
}
