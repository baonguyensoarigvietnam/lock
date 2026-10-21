import 'package:applock/application/router/router_endpoint.dart';
import 'package:applock/domain/model/lock_screen_args.dart';
import 'package:applock/presentation/common/base/base_navigator.dart';

class AppsNavigator extends BaseNavigator {
  const AppsNavigator({required super.router});

  void goToLockScreen({String? appName, String? packageName}) => router.push(
        RouterEndpoint.lockScreen.path,
        extra: LockScreenArgs(appName: appName, packageName: packageName),
      );
}
