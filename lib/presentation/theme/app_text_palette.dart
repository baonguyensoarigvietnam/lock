import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';

abstract final class AppTypography {
  static const TextStyle regular = _AppTextStyle(
    fontWeight: FontWeight.w400,
  );

  static const TextStyle medium = _AppTextStyle(
    fontWeight: FontWeight.w500,
  );

  static const TextStyle semiBold = _AppTextStyle(
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bold = _AppTextStyle(
    fontWeight: FontWeight.w700,
  );
}

class _AppTextStyle extends TextStyle {
  const _AppTextStyle({required super.fontWeight})
      : super(inherit: true, color: AppColorsPalette.black, height: 1.2);
}
