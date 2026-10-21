import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/app_lock_shield_badge.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/screen/onboarding/widget/onboarding_feature_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class OnboardingStepTwoView extends StatelessWidget {
  final VoidCallback onGetStarted;

  const OnboardingStepTwoView({
    super.key,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
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
            'Local-only protection',
            style: AppTypography.bold.copyWith(
              fontSize: 23,
              color: AppColorsPalette.black,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Your data never leaves your device.',
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
                children: const [
                  OnboardingFeatureCard(
                    icon: Icons.no_accounts_outlined,
                    title: 'No account',
                    description:
                        'We don\'t ask for your email or phone number to use the app.',
                  ),
                  OnboardingFeatureCard(
                    icon: Icons.cloud_off_outlined,
                    title: 'No cloud sync',
                    description:
                        'Your data is never uploaded to any external servers or clouds.',
                  ),
                  OnboardingFeatureCard(
                    icon: Icons.lock_reset_outlined,
                    title: 'No server-side recovery',
                    description:
                        'If you lose your PIN, we cannot recover your data for you.',
                  ),
                  OnboardingFeatureCard(
                    icon: Icons.snippet_folder_outlined,
                    title: 'Vault files stay here',
                    description:
                        'Everything secured in the vault remains strictly on this device.',
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
              text: 'Get started',
              onPressed: onGetStarted,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
