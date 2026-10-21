import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_app_lock_header.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/common/widget/common_feature_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class AlertsCameraDeniedView extends StatelessWidget {
  final VoidCallback onOpenSettingsTap;

  const AlertsCameraDeniedView({
    required this.onOpenSettingsTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Top Title: App Lock
          const CommonAppLockHeader(),
          const SizedBox(height: 36),

          // Crossed-out Camera Circle
          Container(
            width: 112,
            height: 112,
            decoration: BoxDecoration(
              color: AppColorsPalette.gray50,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColorsPalette.gray200,
                width: 1.5,
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.no_photography_outlined,
                size: 46,
                color: AppColorsPalette.black,
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Title
          Text(
            'Camera permission denied',
            textAlign: TextAlign.center,
            style: AppTypography.bold.copyWith(
              fontSize: 22,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(height: 10),

          // Subtitle
          Text(
            'Intruder events can still be recorded\nwithout a photo.',
            textAlign: TextAlign.center,
            style: AppTypography.regular.copyWith(
              fontSize: 14,
              color: AppColorsPalette.gray500,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 32),

          // Feature Card 1: Intruder Logging
          const CommonFeatureCard(
            icon: Icons.history_rounded,
            title: 'Intruder Logging',
            subtitle:
                'Time, date, and attempted PINs will still\nbe stored in your security vault.',
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          ),
          const SizedBox(height: 14),

          // Feature Card 2: Privacy First
          const CommonFeatureCard(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy First',
            subtitle:
                'No photos are taken or stored without\nyour explicit camera permission.',
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          ),
          const SizedBox(height: 32),

          // Open settings Button
          CommonButton.filled(
            text: 'Open settings',
            height: 48,
            cornerRadius: 10,
            backgroundColor: AppColorsPalette.black,
            textColor: AppColorsPalette.white,
            textStyle: AppTypography.semiBold.copyWith(
              fontSize: 14,
              color: AppColorsPalette.white,
            ),
            onPressed: onOpenSettingsTap,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
