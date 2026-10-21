import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class LockScreenRecoverAccessView extends StatelessWidget {
  final VoidCallback onAuthenticate;
  final VoidCallback onResetAppSecurity;
  final VoidCallback onBackToUnlock;

  const LockScreenRecoverAccessView({
    super.key,
    required this.onAuthenticate,
    required this.onResetAppSecurity,
    required this.onBackToUnlock,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recover access',
            style: AppTypography.bold.copyWith(
              fontSize: 24,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(height: 20),

          // Card 1: Use biometric fallback
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColorsPalette.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColorsPalette.gray200,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Use biometric fallback',
                  style: AppTypography.bold.copyWith(
                    fontSize: 16,
                    color: AppColorsPalette.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Authenticate with device biometrics, then create a new PIN or pattern.',
                  style: AppTypography.regular.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.gray500,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),
                CommonButton.filled(
                  text: 'Authenticate',
                  height: 48,
                  cornerRadius: 10,
                  backgroundColor: AppColorsPalette.black,
                  textColor: AppColorsPalette.white,
                  textStyle: AppTypography.semiBold.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.white,
                  ),
                  onPressed: onAuthenticate,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Card 2: Vault cannot be recovered
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColorsPalette.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColorsPalette.gray200,
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vault cannot be recovered',
                  style: AppTypography.bold.copyWith(
                    fontSize: 16,
                    color: AppColorsPalette.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Without PIN, pattern, or biometric fallback, encrypted vault data cannot be recovered.',
                  style: AppTypography.regular.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.gray500,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),
                CommonButton.outline(
                  text: 'Reset app security',
                  height: 48,
                  cornerRadius: 10,
                  backgroundColor: AppColorsPalette.white,
                  borderColor: AppColorsPalette.black,
                  borderWidth: 1,
                  textColor: AppColorsPalette.black,
                  textStyle: AppTypography.semiBold.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.black,
                  ),
                  onPressed: onResetAppSecurity,
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Bottom "Back to unlock" link
          Center(
            child: GestureDetector(
              onTap: onBackToUnlock,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                child: Text(
                  'Back to unlock',
                  style: AppTypography.semiBold.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.gray600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
