import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';

/// Reusable circular shield badge shown in Splash and Onboarding header.
class AppLockShieldBadge extends StatelessWidget {
  final double size;
  final double iconSize;

  const AppLockShieldBadge({
    super.key,
    this.size = 86,
    this.iconSize = 38,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColorsPalette.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColorsPalette.gray200,
          width: 1.2,
        ),
      ),
      child: Center(
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.shield,
                size: iconSize,
                color: AppColorsPalette.black,
              ),
              Icon(
                Icons.lock,
                size: iconSize * 0.46,
                color: AppColorsPalette.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
