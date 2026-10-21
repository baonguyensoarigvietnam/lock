import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

enum PermissionBadgeType {
  required,
  recommended,
  vault,
  intruder,
}

class PermissionSetupItemCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String badgeText;
  final PermissionBadgeType badgeType;
  final bool isGranted;
  final VoidCallback onTap;

  const PermissionSetupItemCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.badgeText,
    required this.badgeType,
    required this.isGranted,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isRequired = badgeType == PermissionBadgeType.required;

    return Material(
      color: AppColorsPalette.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColorsPalette.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isGranted
                  ? AppColorsPalette.green500.withValues(alpha: 0.6)
                  : AppColorsPalette.gray200,
              width: 1.2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: isGranted
                      ? AppColorsPalette.green500.withValues(alpha: 0.12)
                      : AppColorsPalette.gray100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 22,
                  color: isGranted
                      ? AppColorsPalette.green600
                      : AppColorsPalette.black,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: AppTypography.bold.copyWith(
                              fontSize: 15.5,
                              color: AppColorsPalette.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2.5,
                          ),
                          decoration: BoxDecoration(
                            color: isRequired
                                ? AppColorsPalette.black
                                : AppColorsPalette.gray200,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            badgeText,
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: isRequired
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                              letterSpacing: 0.4,
                              color: isRequired
                                  ? AppColorsPalette.white
                                  : AppColorsPalette.gray600,
                            ),
                          ),
                        ),
                        const Spacer(),
                        if (isGranted)
                          const Icon(
                            Icons.check_circle_rounded,
                            color: AppColorsPalette.green500,
                            size: 20,
                          )
                        else
                          const Icon(
                            Icons.chevron_right_rounded,
                            color: AppColorsPalette.gray400,
                            size: 20,
                          ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      style: AppTypography.regular.copyWith(
                        fontSize: 13,
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
      ),
    );
  }
}
