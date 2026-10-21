import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class AppsLimitedProtectionView extends StatelessWidget {
  final bool isOverlayGranted;
  final bool isBatteryOptimizationIgnored;
  final VoidCallback onFixPermissions;
  final VoidCallback onContinueLimited;

  const AppsLimitedProtectionView({
    required this.isOverlayGranted,
    required this.isBatteryOptimizationIgnored,
    required this.onFixPermissions,
    required this.onContinueLimited,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          // Red Warning Circle
          Container(
            width: 68,
            height: 68,
            decoration: const BoxDecoration(
              color: AppColorsPalette.red50,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.warning_amber_rounded,
                color: AppColorsPalette.red600,
                size: 32,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            l10n.protectionMayBeLimitedTitle,
            textAlign: TextAlign.center,
            style: AppTypography.bold.copyWith(
              fontSize: 22,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              l10n.protectionMayBeLimitedDesc,
              textAlign: TextAlign.center,
              style: AppTypography.regular.copyWith(
                fontSize: 14,
                color: AppColorsPalette.gray500,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Card 1: Display over other apps (highlighted border with thick left bar)
          if (!isOverlayGranted) ...[
            Container(
              decoration: BoxDecoration(
                color: AppColorsPalette.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColorsPalette.black, width: 1.5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.5),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: AppColorsPalette.black,
                        width: 3.5,
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.layers_outlined,
                            size: 20,
                            color: AppColorsPalette.black,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              l10n.displayOverOtherAppsTitle,
                              style: AppTypography.bold.copyWith(
                                fontSize: 15,
                                color: AppColorsPalette.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Text(
                          l10n.displayOverOtherAppsWarningDesc,
                          style: AppTypography.regular.copyWith(
                            fontSize: 13,
                            color: AppColorsPalette.gray500,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColorsPalette.red50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.cancel_outlined,
                                size: 13,
                                color: AppColorsPalette.red600,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                l10n.statusDisabled,
                                style: AppTypography.medium.copyWith(
                                  fontSize: 12,
                                  color: AppColorsPalette.red600,
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
            const SizedBox(height: 14),
          ],

          // Card 2: Battery optimization
          if (!isBatteryOptimizationIgnored) ...[
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
              decoration: BoxDecoration(
                color: AppColorsPalette.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColorsPalette.gray200, width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.battery_saver_rounded,
                        size: 20,
                        color: AppColorsPalette.gray500,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l10n.batteryOptimizationTitle,
                          style: AppTypography.bold.copyWith(
                            fontSize: 15,
                            color: AppColorsPalette.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(
                      l10n.batteryOptimizationDesc,
                      style: AppTypography.regular.copyWith(
                        fontSize: 13,
                        color: AppColorsPalette.gray500,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColorsPalette.gray100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.info_outline_rounded,
                            size: 13,
                            color: AppColorsPalette.gray600,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            l10n.statusRestricted,
                            style: AppTypography.medium.copyWith(
                              fontSize: 12,
                              color: AppColorsPalette.gray600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 24),

          // Primary Button: Fix permissions
          CommonButton.filled(
            text: l10n.fixPermissionsButton,
            height: 50,
            cornerRadius: 12,
            backgroundColor: AppColorsPalette.black,
            textColor: AppColorsPalette.white,
            textStyle: AppTypography.semiBold.copyWith(
              fontSize: 15,
              color: AppColorsPalette.white,
            ),
            onPressed: onFixPermissions,
          ),
          const SizedBox(height: 10),

          // Secondary Button: Continue with limited protection
          CommonButton.outline(
            text: l10n.continueWithLimitedProtectionButton,
            height: 50,
            cornerRadius: 12,
            backgroundColor: AppColorsPalette.white,
            borderColor: AppColorsPalette.gray200,
            borderWidth: 1,
            textColor: AppColorsPalette.black,
            textStyle: AppTypography.semiBold.copyWith(
              fontSize: 15,
              color: AppColorsPalette.black,
            ),
            onPressed: onContinueLimited,
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
