import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/presentation/common/base/base_navigator.dart';

class SetPasscodeNavigator extends BaseNavigator {
  const SetPasscodeNavigator({required super.router});

  void goBack() {
    if (router.canPop()) {
      router.pop();
    }
  }

  void goToPattern() => router.pushReplacement(RouterEndpoint.setPattern.path);

  void goToEnableBiometric() =>
      router.go(RouterEndpoint.enableBiometric.path);

  void goToHome() => router.go(RouterEndpoint.home.path);
}
