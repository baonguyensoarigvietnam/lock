import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class PaywallFeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const PaywallFeatureTile({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColorsPalette.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            size: 24,
            color: AppColorsPalette.black,
          ),
          const SizedBox(height: 14),
          Text(
            title,
            maxLines: 2,
            style: AppTypography.medium.copyWith(
              fontSize: 14,
              color: AppColorsPalette.black,
              height: 1.25,
            ),
          ),
        ],
      ),
    );
  }
}
