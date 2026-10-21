import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class AppsLimitedProtectionView extends StatelessWidget {
  final VoidCallback onFixPermissions;
  final VoidCallback onContinueLimited;

  const AppsLimitedProtectionView({
    required this.onFixPermissions,
    required this.onContinueLimited,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              color: Color(0xFFFEE2E2),
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
            'Protection may be limited',
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
              'To ensure App Lock works reliably in the background, please review the following Android system settings.',
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
          Container(
            decoration: BoxDecoration(
              color: AppColorsPalette.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: AppColorsPalette.black,
                width: 1.5,
              ),
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
                            'Display over other apps',
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
                        'Required to show the lock screen over protected apps. Without this, apps will not be locked.',
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
                          color: const Color(0xFFFEE2E2),
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
                              'Disabled',
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

          // Card 2: Battery optimization
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
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
                        'Battery optimization',
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
                    'Android may aggressively kill App Lock in the background. Disable optimization to keep protection active.',
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
                          'Restricted',
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
          const SizedBox(height: 24),

          // Primary Button: Fix permissions
          CommonButton.filled(
            text: 'Fix permissions',
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
            text: 'Continue with limited protection',
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
