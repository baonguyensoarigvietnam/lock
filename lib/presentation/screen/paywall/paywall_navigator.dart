import 'package:applock/presentation/common/base/base_navigator.dart';

class PaywallNavigator extends BaseNavigator {
  const PaywallNavigator({required super.router});

  void close() {
    if (router.canPop()) {
      router.pop();
    }
  }
}
