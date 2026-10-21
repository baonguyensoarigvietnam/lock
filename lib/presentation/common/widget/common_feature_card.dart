import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

/// Reusable feature/info card with a rounded icon box, bold title, and optional subtitle.
class CommonFeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  const CommonFeatureCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.backgroundColor = AppColorsPalette.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColorsPalette.gray200,
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColorsPalette.gray100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 21,
                color: AppColorsPalette.black,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: AppTypography.bold.copyWith(
                    fontSize: 15.5,
                    color: AppColorsPalette.black,
                    height: 1.3,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 3),
                  Text(
                    subtitle!,
                    style: AppTypography.regular.copyWith(
                      fontSize: 13.5,
                      color: AppColorsPalette.gray500,
                      height: 1.35,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
