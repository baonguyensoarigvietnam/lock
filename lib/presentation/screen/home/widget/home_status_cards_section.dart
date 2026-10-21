import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class HomeStatusCardsSection extends StatelessWidget {
  final int lockedCount;
  final bool isServiceActive;
  final int vaultItemsCount;
  final int intruderAlertsCount;
  final VoidCallback onAppsProtectedTap;
  final VoidCallback onVaultTap;
  final VoidCallback onAlertsTap;

  const HomeStatusCardsSection({
    required this.lockedCount,
    required this.isServiceActive,
    this.vaultItemsCount = 72,
    this.intruderAlertsCount = 2,
    required this.onAppsProtectedTap,
    required this.onVaultTap,
    required this.onAlertsTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SizedBox(
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Card: Apps protected
          Expanded(
            flex: 1,
            child: Material(
              color: AppColorsPalette.transparent,
              child: InkWell(
                onTap: onAppsProtectedTap,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColorsPalette.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColorsPalette.gray200,
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.lock_rounded,
                            size: 22,
                            color: AppColorsPalette.black,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3.5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColorsPalette.gray100,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              isServiceActive
                                  ? l10n.statusActive
                                  : l10n.statusIdle,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColorsPalette.gray700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$lockedCount',
                            style: AppTypography.bold.copyWith(
                              fontSize: 30,
                              color: AppColorsPalette.black,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            l10n.appsProtectedLabel,
                            style: AppTypography.regular.copyWith(
                              fontSize: 13,
                              color: AppColorsPalette.gray600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Right Stack of 2 Cards
          Expanded(
            flex: 1,
            child: Column(
              children: [
                // Top Card: Vault items
                Expanded(
                  child: Material(
                    color: AppColorsPalette.transparent,
                    child: InkWell(
                      onTap: onVaultTap,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColorsPalette.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColorsPalette.gray200,
                            width: 1.2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: AppColorsPalette.gray50,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.folder_outlined,
                                size: 22,
                                color: AppColorsPalette.black,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$vaultItemsCount',
                                    style: AppTypography.bold.copyWith(
                                      fontSize: 17,
                                      color: AppColorsPalette.black,
                                    ),
                                  ),
                                  Text(
                                    l10n.vaultItemsLabel,
                                    style: AppTypography.regular.copyWith(
                                      fontSize: 12,
                                      color: AppColorsPalette.gray600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Bottom Card: Intruder alerts (with black accent line on left)
                Expanded(
                  child: Material(
                    color: AppColorsPalette.transparent,
                    child: InkWell(
                      onTap: onAlertsTap,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColorsPalette.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColorsPalette.gray200,
                            width: 1.2,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Row(
                            children: [
                              // Distinctive black left indicator bar from design
                              Container(
                                width: 4.0,
                                color: AppColorsPalette.black,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 38,
                                        height: 38,
                                        decoration: BoxDecoration(
                                          color: AppColorsPalette.gray100,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Icon(
                                          Icons.warning_amber_rounded,
                                          size: 22,
                                          color: AppColorsPalette.black,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '$intruderAlertsCount',
                                              style:
                                                  AppTypography.bold.copyWith(
                                                fontSize: 17,
                                                color: AppColorsPalette.black,
                                              ),
                                            ),
                                            Text(
                                              l10n.intruderAlertsLabel,
                                              style: AppTypography.regular
                                                  .copyWith(
                                                fontSize: 12,
                                                color: AppColorsPalette.gray600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
