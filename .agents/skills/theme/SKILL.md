---
name: "theme"
description: "Theme configuration, Colors Palette, and Text Palette."
---
Summary: Theme configuration, Colors Palette, and Text Palette.

# Theme System

The design system is located in `lib/presentation/theme/`.

## 1. AppTheme
The main theme provider using Material 3. It enforces a dark mode by default.
```dart
abstract final class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      textTheme: AppTextPalette.textTheme,
      scaffoldBackgroundColor: AppColorsPalette.black,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColorsPalette.yellow350,
      ),
    );
  }
}
```

## 2. Colors Palette
Never hardcode colors. Use `AppColorsPalette`.

```dart
// Example usage:
Container(color: AppColorsPalette.yellow400)
```
*(Colors like `yellow400`, `gray300`, `black` are defined as static constants in `app_colors_palette.dart`)*

## 3. App Typography
Text styles are managed through `AppTypography`. It defines specific semantics like code bewlow etc.

```

abstract final class AppTypography {
  
  // Font families
  static const String roundedMplus1c = 'Rounded Mplus 1c';
  static const String goldmanSans = 'Goldman Sans';
  static const String lilitaOne = 'Lilita One';

  // --- Rounded Mplus 1c ---

  // Size 10
  static const TextStyle roundedMplus1c10ExtraBold = _AppTextStyle(
    fontFamily: roundedMplus1c,
    fontSize: 10,
    fontWeight: FontWeight.w800,
    fontVariations: AppFontVariations.w800,
  );

  // Size 12
  static const TextStyle roundedMplus1c12ExtraBold = _AppTextStyle(
    fontFamily: roundedMplus1c,
    fontSize: 12,
    fontWeight: FontWeight.w800,
    fontVariations: AppFontVariations.w800,
  );
}

class _AppTextStyle extends TextStyle {
  const _AppTextStyle({
    required super.fontFamily,
    required super.fontSize,
    required super.fontWeight,
    required super.fontVariations,
  });
}

```

```dart
// Example usage:
Text(
  'Total Coins',
  style: AppTypography.roundedMplus1c10ExtraBold.copyWith(
    color: AppColorsPalette.blue,
  ),
)
```

## 4. Spacing and Dimensions
Dimensions, margins, and standard heights are found in `DimensionConstants` (`lib/utility/constant/dimension_constant.dart`).
