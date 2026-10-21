import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/presentation/common/base/base_navigator.dart';

class VaultNavigator extends BaseNavigator {
  const VaultNavigator({required super.router});

  /// Opens the paywall (e.g. when the free plan vault limit is reached).
  void goToPaywall() {
    router.push(RouterEndpoint.paywall.path);
  }
}
