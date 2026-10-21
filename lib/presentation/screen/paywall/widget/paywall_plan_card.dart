import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class PaywallPlanCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String? originalPrice;
  final String? badgeText;
  final bool isSelected;
  final VoidCallback onTap;

  const PaywallPlanCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    this.originalPrice,
    this.badgeText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: AppColorsPalette.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColorsPalette.black : AppColorsPalette.gray200,
                width: isSelected ? 1.5 : 1.0,
              ),
            ),
            child: Row(
              children: [
                // Radio indicator
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? AppColorsPalette.black
                          : AppColorsPalette.gray300,
                      width: 1.5,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColorsPalette.black,
                            ),
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 14),
                // Title & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTypography.bold.copyWith(
                          fontSize: 16,
                          color: AppColorsPalette.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: AppTypography.regular.copyWith(
                          fontSize: 13,
                          color: AppColorsPalette.gray500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Price section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: AppTypography.bold.copyWith(
                        fontSize: 17,
                        color: AppColorsPalette.black,
                      ),
                    ),
                    if (originalPrice != null) ...[
                      const SizedBox(height: 1),
                      Text(
                        context.l10n.wasPrice(originalPrice!),
                        style: AppTypography.regular.copyWith(
                          fontSize: 12,
                          color: AppColorsPalette.gray500,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          // Top right badge (e.g. SAVE 40%)
          if (badgeText != null)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: const BoxDecoration(
                  color: AppColorsPalette.black,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child: Text(
                  badgeText!,
                  style: AppTypography.bold.copyWith(
                    color: AppColorsPalette.white,
                    fontSize: 10.5,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
