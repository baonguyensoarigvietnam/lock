import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/presentation/common/base/base_navigator.dart';

class LockScreenNavigator extends BaseNavigator {
  const LockScreenNavigator({required super.router});

  /// Preview / in-app usage: just close the lock screen.
  void unlockSuccess() {
    if (router.canPop()) {
      router.pop(true);
    } else {
      router.go(RouterEndpoint.home.path);
    }
  }

  /// App Lock itself was unlocked: continue where the user left off.
  void enterApp() {
    if (router.canPop()) {
      router.pop(true);
    } else {
      router.go(RouterEndpoint.home.path);
    }
  }

  void goBack() {
    if (router.canPop()) {
      router.pop();
    }
  }

  /// Closes the lock screen route after the external flow finished, leaving
  /// the app on the home screen for the next time it is opened.
  void closeExternal() {
    if (router.canPop()) {
      router.pop();
    } else {
      router.go(RouterEndpoint.home.path);
    }
  }

  void goToUnlockMethod() {
    router.go(RouterEndpoint.unlockMethod.path);
  }
}
