import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class HomePremiumColorPreviewView extends StatelessWidget {
  final VoidCallback onUpgradeToPremium;
  final VoidCallback onBackToThemes;

  const HomePremiumColorPreviewView({
    required this.onUpgradeToPremium,
    required this.onBackToThemes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 12),
          const CommonAppBar.brand(),
          const SizedBox(height: 24),

          // Header Row: "Premium Color Preview" + "PREMIUM" Pill Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Premium Color Preview',
                style: AppTypography.bold.copyWith(
                  fontSize: 17,
                  color: AppColorsPalette.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColorsPalette.black,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  'PREMIUM',
                  style: AppTypography.semiBold.copyWith(
                    fontSize: 11,
                    letterSpacing: 0.6,
                    color: AppColorsPalette.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Large Preview Card
          Container(
            width: double.infinity,
            height: 316,
            decoration: BoxDecoration(
              color: AppColorsPalette.gray50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColorsPalette.gray200,
                width: 1,
              ),
            ),
            child: Center(
              child: Container(
                width: 62,
                height: 62,
                decoration: const BoxDecoration(
                  color: AppColorsPalette.gray550,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.lock_outline_rounded,
                    size: 28,
                    color: AppColorsPalette.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Subscription Info Text
          Text(
            'Premium themes are available with subscription.',
            textAlign: TextAlign.center,
            style: AppTypography.regular.copyWith(
              fontSize: 14,
              color: AppColorsPalette.gray500,
            ),
          ),
          const SizedBox(height: 28),

          // Upgrade to Premium Button
          CommonButton.filled(
            text: 'Upgrade to Premium',
            height: 48,
            cornerRadius: 10,
            backgroundColor: AppColorsPalette.black,
            textColor: AppColorsPalette.white,
            textStyle: AppTypography.semiBold.copyWith(
              fontSize: 14,
              color: AppColorsPalette.white,
            ),
            onPressed: onUpgradeToPremium,
          ),
          const SizedBox(height: 10),

          // Back to themes Button
          CommonButton.outline(
            text: 'Back to themes',
            height: 48,
            cornerRadius: 10,
            backgroundColor: AppColorsPalette.white,
            borderColor: AppColorsPalette.gray200,
            borderWidth: 1,
            textColor: AppColorsPalette.black,
            textStyle: AppTypography.semiBold.copyWith(
              fontSize: 14,
              color: AppColorsPalette.black,
            ),
            onPressed: onBackToThemes,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
