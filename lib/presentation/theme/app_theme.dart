import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';

/// [ThemeData] for this application
abstract final class AppTheme {

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColorsPalette.primary,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppColorsPalette.slate900,
      appBarTheme: const AppBarTheme(
        scrolledUnderElevation: 0,
        backgroundColor: AppColorsPalette.slate800,
        elevation: 0,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColorsPalette.primary,
      ),
    );
  }
}
