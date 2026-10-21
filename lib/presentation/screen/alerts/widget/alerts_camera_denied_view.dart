import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/common/widget/common_feature_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class AlertsCameraDeniedView extends StatelessWidget {
  final VoidCallback onOpenSettingsTap;

  /// When `true` the permission can only be granted from the system settings.
  final bool isPermanentlyDenied;

  const AlertsCameraDeniedView({
    required this.onOpenSettingsTap,
    required this.isPermanentlyDenied,
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
            l10n.cameraPermissionDeniedTitle,
            textAlign: TextAlign.center,
            style: AppTypography.bold.copyWith(
              fontSize: 22,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(height: 10),

          // Subtitle
          Text(
            l10n.cameraPermissionDeniedSubtitle,
            textAlign: TextAlign.center,
            style: AppTypography.regular.copyWith(
              fontSize: 14,
              color: AppColorsPalette.gray500,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 32),

          // Feature Card 1: Intruder Logging
          CommonFeatureCard(
            icon: Icons.history_rounded,
            title: l10n.intruderLoggingTitle,
            subtitle: l10n.intruderLoggingSubtitle,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          ),
          const SizedBox(height: 14),

          // Feature Card 2: Privacy First
          CommonFeatureCard(
            icon: Icons.privacy_tip_outlined,
            title: l10n.privacyFirstTitle,
            subtitle: l10n.privacyFirstSubtitle,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          ),
          const SizedBox(height: 32),

          // Open settings Button
          CommonButton.filled(
            text: isPermanentlyDenied
                ? l10n.openSettingsButton
                : l10n.enableCameraPermissionButton,
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
