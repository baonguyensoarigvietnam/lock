import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/app_lock_shield_badge.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/screen/onboarding/widget/onboarding_feature_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class OnboardingStepTwoView extends StatelessWidget {
  final VoidCallback onGetStarted;

  const OnboardingStepTwoView({
    super.key,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Top Title
          const CommonAppBar.brand(),
          const SizedBox(height: 20),
          // Shield Badge
          const AppLockShieldBadge(
            size: 64,
            iconSize: 30,
          ),
          const SizedBox(height: 18),
          // Title & Subtitle
          Text(
            l10n.onboardingStep2Title,
            style: AppTypography.bold.copyWith(
              fontSize: 23,
              color: AppColorsPalette.black,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.onboardingStep2Subtitle,
            style: AppTypography.regular.copyWith(
              fontSize: 14,
              color: AppColorsPalette.gray600,
            ),
          ),
          const SizedBox(height: 20),
          // 4 Feature Cards
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  OnboardingFeatureCard(
                    icon: Icons.no_accounts_outlined,
                    title: l10n.onboardingNoAccountTitle,
                    description: l10n.onboardingNoAccountDesc,
                  ),
                  OnboardingFeatureCard(
                    icon: Icons.cloud_off_outlined,
                    title: l10n.onboardingNoCloudTitle,
                    description: l10n.onboardingNoCloudDesc,
                  ),
                  OnboardingFeatureCard(
                    icon: Icons.lock_reset_outlined,
                    title: l10n.onboardingNoRecoveryTitle,
                    description: l10n.onboardingNoRecoveryDesc,
                  ),
                  OnboardingFeatureCard(
                    icon: Icons.snippet_folder_outlined,
                    title: l10n.onboardingVaultStaysTitle,
                    description: l10n.onboardingVaultStaysDesc,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          // Bottom Get Started Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CommonButton.filled(
              text: l10n.getStartedButton,
              onPressed: onGetStarted,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
