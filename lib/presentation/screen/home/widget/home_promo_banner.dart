import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/application/view_model/global_view_model.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class HomePromoBanner extends StatelessWidget {
  final VoidCallback onTap;

  const HomePromoBanner({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Nullable lookup: the banner still renders when no GlobalViewModel is
    // provided (e.g. widget tests).
    final isPremium = context.select<GlobalViewModel?, bool>(
      (vm) => vm?.state.isPremium ?? false,
    );
    if (isPremium) return const SizedBox.shrink();

    final l10n = context.l10n;
    return Material(
      color: AppColorsPalette.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: AppColorsPalette.gray900,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.promoBannerTitle,
                      style: AppTypography.bold.copyWith(
                        fontSize: 15.5,
                        color: AppColorsPalette.white,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      l10n.promoBannerSubtitle,
                      style: AppTypography.regular.copyWith(
                        fontSize: 12.5,
                        color: AppColorsPalette.gray400,
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
