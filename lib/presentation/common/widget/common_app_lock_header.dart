import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

/// Shared top centered "App Lock" header used across main tabs and setup flows.
class CommonAppLockHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const CommonAppLockHeader({
    super.key,
    this.title = 'App Lock',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textWidget = Center(
      child: Text(
        title,
        style: AppTypography.bold.copyWith(
          fontSize: 20,
          color: AppColorsPalette.black,
        ),
      ),
    );

    if (onTap == null) {
      return textWidget;
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: textWidget,
    );
  }
}
