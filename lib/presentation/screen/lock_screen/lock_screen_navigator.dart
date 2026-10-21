import 'package:applock/presentation/common/base/base_navigator.dart';

class LockScreenNavigator extends BaseNavigator {
  const LockScreenNavigator({required super.router});

  void unlockSuccess() {
    if (router.canPop()) {
      router.pop(true);
    }
  }
}
