import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class HomePromoBanner extends StatelessWidget {
  final VoidCallback onTap;

  const HomePromoBanner({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF111827),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UNLOCK ALL FEATURES',
                      style: AppTypography.bold.copyWith(
                        fontSize: 15.5,
                        color: AppColorsPalette.white,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Unlimited themes, free ads and more.',
                      style: AppTypography.regular.copyWith(
                        fontSize: 12.5,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Icon(
                Icons.star_border_rounded,
                size: 28,
                color: AppColorsPalette.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
