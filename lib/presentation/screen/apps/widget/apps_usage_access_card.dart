import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class AppsUsageAccessCard extends StatelessWidget {
  final VoidCallback onEnableTap;

  const AppsUsageAccessCard({
    required this.onEnableTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          decoration: BoxDecoration(
            color: AppColorsPalette.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColorsPalette.gray200,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: AppColorsPalette.gray100,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.error_outline_rounded,
                    color: AppColorsPalette.gray500,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.usageAccessRequiredTitle,
                textAlign: TextAlign.center,
                style: AppTypography.bold.copyWith(
                  fontSize: 18,
                  color: AppColorsPalette.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.usageAccessRequiredDesc,
                textAlign: TextAlign.center,
                style: AppTypography.regular.copyWith(
                  fontSize: 14,
                  color: AppColorsPalette.gray500,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              CommonButton.filled(
                text: l10n.enableUsageAccessButton,
                height: 48,
                cornerRadius: 10,
                backgroundColor: AppColorsPalette.black,
                textColor: AppColorsPalette.white,
                textStyle: AppTypography.semiBold.copyWith(
                  fontSize: 14,
                  color: AppColorsPalette.white,
                ),
                onPressed: onEnableTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
