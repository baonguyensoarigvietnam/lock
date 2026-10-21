import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/presentation/common/base/base_navigator.dart';

class LockScreenNavigator extends BaseNavigator {
  const LockScreenNavigator({required super.router});

  void unlockSuccess() {
    if (router.canPop()) {
      router.pop(true);
    }
  }

  void goBack() {
    if (router.canPop()) {
      router.pop();
    }
  }

  void goToUnlockMethod() {
    router.pushReplacement(RouterEndpoint.unlockMethod.path);
  }
}
