import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';

/// Graphic illustration box for Onboarding Step 1 matching Screenshot 2.
class OnboardingGraphicBox extends StatelessWidget {
  const OnboardingGraphicBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 260,
        maxHeight: 320,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColorsPalette.gray100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColorsPalette.blue600,
          width: 1.5,
        ),
      ),
      child: Center(
        child: SizedBox(
          width: 160,
          height: 160,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer diamond 1
              Transform.rotate(
                angle: math.pi / 4,
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColorsPalette.gray400.withValues(alpha: 0.6),
                      width: 1.2,
                    ),
                  ),
                ),
              ),
              // Outer diamond 2 (slightly offset/larger)
              Transform.rotate(
                angle: math.pi / 4 + 0.12,
                child: Container(
                  width: 98,
                  height: 98,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColorsPalette.gray400.withValues(alpha: 0.4),
                      width: 1.2,
                    ),
                  ),
                ),
              ),
              // Center solid shield
              SizedBox(
                width: 58,
                height: 58,
                child: Stack(
                  alignment: Alignment.center,
                  children: const [
                    Icon(
                      Icons.shield,
                      size: 58,
                      color: AppColorsPalette.black,
                    ),
                    Icon(
                      Icons.lock,
                      size: 26,
                      color: AppColorsPalette.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
