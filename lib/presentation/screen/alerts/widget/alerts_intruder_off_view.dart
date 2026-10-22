import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/banner_ad_widget.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/common/widget/common_feature_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class AlertsIntruderOffView extends StatelessWidget {
  final VoidCallback onEnableTap;

  const AlertsIntruderOffView({
    required this.onEnableTap,
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
          // Top Title: App Lock
          const CommonAppBar.brand(),
          const SizedBox(height: 18),
          const BannerAdWidget(
            useAdaptiveSize: true,
            padding: EdgeInsets.only(bottom: 18),
          ),

          // Shutter Icon Circle with Red Close Badge
          SizedBox(
            width: 118,
            height: 118,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 112,
                    height: 112,
                    decoration: const BoxDecoration(
                      color: AppColorsPalette.gray100,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.camera_outlined,
                        size: 48,
                        color: AppColorsPalette.black,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 6,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColorsPalette.red700,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColorsPalette.white,
                        width: 3,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.close_rounded,
                        size: 16,
                        color: AppColorsPalette.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Title
          Text(
            l10n.intruderSelfieOffTitle,
            textAlign: TextAlign.center,
            style: AppTypography.bold.copyWith(
              fontSize: 22,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(height: 10),

          // Subtitle
          Text(
            l10n.intruderSelfieOffSubtitle,
            textAlign: TextAlign.center,
            style: AppTypography.regular.copyWith(
              fontSize: 14,
              color: AppColorsPalette.gray500,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 32),

          // Feature Card 1: Secure Logs
          CommonFeatureCard(
            icon: Icons.security_rounded,
            title: l10n.secureLogsTitle,
            subtitle: l10n.secureLogsSubtitle,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          ),
          const SizedBox(height: 14),

          // Feature Card 2: Stealth Capture
          CommonFeatureCard(
            icon: Icons.visibility_off_outlined,
            title: l10n.stealthCaptureTitle,
            subtitle: l10n.stealthCaptureSubtitle,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          ),
          const SizedBox(height: 32),

          // Enable Intruder Selfie Button
          CommonButton.filled(
            text: l10n.enableIntruderSelfieButton,
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
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
