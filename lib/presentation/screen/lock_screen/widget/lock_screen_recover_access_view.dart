import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

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
    final l10n = context.l10n;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.recoverAccessTitle,
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
                  l10n.useBiometricFallbackCardTitle,
                  style: AppTypography.bold.copyWith(
                    fontSize: 16,
                    color: AppColorsPalette.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.useBiometricFallbackCardDesc,
                  style: AppTypography.regular.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.gray500,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),
                CommonButton.filled(
                  text: l10n.authenticateButton,
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
                  l10n.vaultCannotBeRecoveredTitle,
                  style: AppTypography.bold.copyWith(
                    fontSize: 16,
                    color: AppColorsPalette.black,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.vaultCannotBeRecoveredDesc,
                  style: AppTypography.regular.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.gray500,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 18),
                CommonButton.outline(
                  text: l10n.resetAppSecurityButton,
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
                  l10n.backToUnlockLink,
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
