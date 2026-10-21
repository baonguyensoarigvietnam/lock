import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_feature_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class VaultImportCompleteView extends StatelessWidget {
  final int encryptedCount;
  final bool originalsDeleted;
  final VoidCallback onToggleVariant;
  final VoidCallback onViewVault;
  final VoidCallback onBackToVaultHome;

  const VaultImportCompleteView({
    super.key,
    this.encryptedCount = 5,
    required this.originalsDeleted,
    required this.onToggleVariant,
    required this.onViewVault,
    required this.onBackToVaultHome,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        children: [
          const SizedBox(height: 16),
          // Concentric Checkmark Circle (tapping toggles between deleted / manual delete variants)
          GestureDetector(
            onTap: onToggleVariant,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 96,
              height: 96,
              decoration: const BoxDecoration(
                color: AppColorsPalette.gray50,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: AppColorsPalette.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColorsPalette.black,
                      width: 1.6,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColorsPalette.black,
                          width: 2.6,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check_rounded,
                          size: 22,
                          color: AppColorsPalette.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),
          Text(
            l10n.importCompleteTitle,
            textAlign: TextAlign.center,
            style: AppTypography.bold.copyWith(
              fontSize: 24,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.importCompleteSubtitle,
            textAlign: TextAlign.center,
            style: AppTypography.regular.copyWith(
              fontSize: 14,
              color: AppColorsPalette.gray500,
            ),
          ),
          const SizedBox(height: 28),

          // Card 1: items encrypted
          CommonFeatureCard(
            icon: Icons.lock_rounded,
            title: l10n.itemsEncryptedTitle(encryptedCount),
            subtitle: l10n.aes256Subtitle,
            backgroundColor: AppColorsPalette.gray50,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
          const SizedBox(height: 12),

          // Card 2: Originals deleted vs Originals could not be deleted automatically
          if (originalsDeleted)
            CommonFeatureCard(
              icon: Icons.delete_sweep_outlined,
              title: l10n.originalsDeletedTitle,
              subtitle: l10n.spaceRecoveredSubtitle,
              backgroundColor: AppColorsPalette.gray50,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            )
          else ...[
            CommonFeatureCard(
              icon: Icons.delete_sweep_outlined,
              title: l10n.originalsCouldNotBeDeletedTitle,
              backgroundColor: AppColorsPalette.gray50,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            const SizedBox(height: 12),
            // Card 3: Next Step Required (highlighted black border)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColorsPalette.gray50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColorsPalette.black,
                  width: 1.5,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColorsPalette.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.info_outline_rounded,
                        size: 20,
                        color: AppColorsPalette.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.nextStepRequiredTitle,
                          style: AppTypography.bold.copyWith(
                            fontSize: 15,
                            color: AppColorsPalette.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.deleteOriginalsManuallyDesc,
                          style: AppTypography.regular.copyWith(
                            fontSize: 13.5,
                            color: AppColorsPalette.gray600,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 24),

          // Primary Button: View Vault ->
          InkWell(
            onTap: onViewVault,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              height: 52,
              decoration: BoxDecoration(
                color: AppColorsPalette.black,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.viewVaultButton,
                    style: AppTypography.semiBold.copyWith(
                      fontSize: 15,
                      color: AppColorsPalette.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 18,
                    color: AppColorsPalette.white,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Secondary Action: Back to Vault Home
          GestureDetector(
            onTap: onBackToVaultHome,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              child: Text(
                l10n.backToVaultHomeLink,
                style: AppTypography.bold.copyWith(
                  fontSize: 14,
                  color: AppColorsPalette.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
