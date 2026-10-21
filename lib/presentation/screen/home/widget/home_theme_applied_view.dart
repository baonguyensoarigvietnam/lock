import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class HomeThemeAppliedView extends StatelessWidget {
  final VoidCallback onDone;

  const HomeThemeAppliedView({
    required this.onDone,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 12),
          const CommonAppBar.brand(),
          const SizedBox(height: 32),

          // Double Circle Checkmark Icon
          Container(
            width: 94,
            height: 94,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColorsPalette.black,
                width: 1.2,
              ),
            ),
            child: Center(
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColorsPalette.black,
                    width: 2.5,
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.check_rounded,
                    size: 26,
                    color: AppColorsPalette.black,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            l10n.themeAppliedTitle,
            textAlign: TextAlign.center,
            style: AppTypography.bold.copyWith(
              fontSize: 22,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(height: 8),

          // Subtitle
          Text(
            l10n.themeAppliedSubtitle,
            textAlign: TextAlign.center,
            style: AppTypography.regular.copyWith(
              fontSize: 14,
              color: AppColorsPalette.gray500,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 28),

          // Two Phone Skeleton Preview Frames
          Row(
            children: [
              Expanded(
                child: _buildPhoneSkeletonPreview(
                  topBarWidth: 46,
                  bottomBarWidth: 34,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _buildPhoneSkeletonPreview(
                  topBarWidth: 38,
                  bottomBarWidth: 50,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Done Button
          CommonButton.filled(
            text: l10n.doneButton,
            height: 48,
            cornerRadius: 10,
            backgroundColor: AppColorsPalette.black,
            textColor: AppColorsPalette.white,
            textStyle: AppTypography.semiBold.copyWith(
              fontSize: 14,
              color: AppColorsPalette.white,
            ),
            onPressed: onDone,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPhoneSkeletonPreview({
    required double topBarWidth,
    required double bottomBarWidth,
  }) {
    return Container(
      height: 264,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColorsPalette.gray200,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColorsPalette.gray250,
          width: 1,
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColorsPalette.gray100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColorsPalette.gray200,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              width: topBarWidth,
              height: 3.5,
              decoration: BoxDecoration(
                color: AppColorsPalette.gray200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: bottomBarWidth,
              height: 3.5,
              decoration: BoxDecoration(
                color: AppColorsPalette.gray200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
