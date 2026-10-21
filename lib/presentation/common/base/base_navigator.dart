import 'package:go_router/go_router.dart';

/// BaseNavigator provides a contract for classes that need to expose a GoRouter instance.
abstract class BaseNavigator {
  final GoRouter router;

  const BaseNavigator({required this.router});
}
