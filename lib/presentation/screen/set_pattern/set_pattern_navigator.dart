import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/presentation/common/base/base_navigator.dart';

class SetPatternNavigator extends BaseNavigator {
  const SetPatternNavigator({required super.router});

  void goBack() {
    if (router.canPop()) {
      router.pop();
    }
  }

  void goToPin() =>
      router.pushReplacement(RouterEndpoint.setPasscode.path);

  void goToEnableBiometric() =>
      router.go(RouterEndpoint.enableBiometric.path);
}
