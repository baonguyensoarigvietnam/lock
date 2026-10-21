import 'package:flutter/material.dart';

/// Utility class for displaying SnackBar messages across the app.
class SnackBarUtility {
  const SnackBarUtility._();

  /// Displays a SnackBar with the given [message].
  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: duration, action: action),
    );
  }
}
