import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/presentation/common/base/base_navigator.dart';

class AlertsNavigator extends BaseNavigator {
  const AlertsNavigator({required super.router});

  void goToPaywall() => router.push(RouterEndpoint.paywall.path);
}
