import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/screen/onboarding/widget/onboarding_graphic_box.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class OnboardingStepOneView extends StatelessWidget {
  final VoidCallback onContinue;

  const OnboardingStepOneView({
    super.key,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Top Header
          const CommonAppBar.brand(),
          const Spacer(flex: 1),
          // Center Graphic Card
          const OnboardingGraphicBox(),
          const Spacer(flex: 1),
          // Title & Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                Text(
                  l10n.onboardingStep1Title,
                  textAlign: TextAlign.center,
                  style: AppTypography.bold.copyWith(
                    fontSize: 24,
                    color: AppColorsPalette.black,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.onboardingStep1Desc,
                  textAlign: TextAlign.center,
                  style: AppTypography.regular.copyWith(
                    fontSize: 15,
                    color: AppColorsPalette.gray600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(flex: 2),
          // Bottom Continue Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CommonButton.filled(
              text: l10n.continueButton,
              onPressed: onContinue,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
