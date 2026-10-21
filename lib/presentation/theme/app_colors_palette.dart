import 'package:flutter/material.dart';

abstract final class AppColorsPalette {
  // Base
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const transparent = Color(0x00000000);

  // Primary / Accent (Security theme: Indigo / Blue / Cyan)
  static const primary = Color(0xFF4F46E5); // Indigo 600
  static const primaryDark = Color(0xFF4338CA);
  static const primaryLight = Color(0xFFEEF2FF);

  // Red / Danger
  static const red100 = Color(0xFFFFDAD6);
  static const red500 = Color(0xFFEF4444);
  static const red600 = Color(0xFFDC2626);

  // Blue
  static const blue50 = Color(0xFFEFF6FF);
  static const blue400 = Color(0xFF38BDF8);
  static const blue500 = Color(0xFF0EA5E9);
  static const blue600 = Color(0xFF2563EB);

  // Grays
  static const gray50 = Color(0xFFF9FAFB);
  static const gray100 = Color(0xFFF3F4F6);
  static const gray200 = Color(0xFFE5E7EB);
  static const gray300 = Color(0xFFD1D5DB);
  static const gray400 = Color(0xFF9CA3AF);
  static const gray500 = Color(0xFF6B7280);
  static const gray600 = Color(0xFF4B5563);
  static const gray700 = Color(0xFF374151);
  static const gray800 = Color(0xFF1F2937);
  static const gray900 = Color(0xFF111827);

  // Slate (Dark surfaces)
  static const slate800 = Color(0xFF1E293B);
  static const slate900 = Color(0xFF0F172A);

  // Green / Success
  static const green500 = Color(0xFF22C55E);
  static const green600 = Color(0xFF16A34A);
}
