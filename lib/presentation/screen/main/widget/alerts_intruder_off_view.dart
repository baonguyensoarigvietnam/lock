import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class AlertsIntruderOffView extends StatelessWidget {
  final VoidCallback onEnableTap;

  const AlertsIntruderOffView({
    required this.onEnableTap,
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
          Center(
            child: Text(
              'App Lock',
              style: AppTypography.bold.copyWith(
                fontSize: 20,
                color: AppColorsPalette.black,
              ),
            ),
          ),
          const SizedBox(height: 36),

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
                      color: const Color(0xFFB91C1C),
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
            'Intruder Selfie is off',
            textAlign: TextAlign.center,
            style: AppTypography.bold.copyWith(
              fontSize: 22,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(height: 10),

          // Subtitle
          Text(
            'Enable it to capture a photo after 3\nfailed unlock attempts.',
            textAlign: TextAlign.center,
            style: AppTypography.regular.copyWith(
              fontSize: 14,
              color: AppColorsPalette.gray500,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 32),

          // Feature Card 1: Secure Logs
          _buildFeatureCard(
            icon: Icons.security_rounded,
            title: 'Secure Logs',
            subtitle: 'View date, time, and photo of\nunauthorized attempts.',
          ),
          const SizedBox(height: 14),

          // Feature Card 2: Stealth Capture
          _buildFeatureCard(
            icon: Icons.visibility_off_outlined,
            title: 'Stealth Capture',
            subtitle: 'The front camera captures the photo\nsilently.',
          ),
          const SizedBox(height: 32),

          // Enable Intruder Selfie Button
          CommonButton.filled(
            text: 'Enable Intruder Selfie',
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

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: AppColorsPalette.white,
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
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColorsPalette.gray100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 20,
                color: AppColorsPalette.black,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.bold.copyWith(
                    fontSize: 15.5,
                    color: AppColorsPalette.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppTypography.regular.copyWith(
                    fontSize: 13.5,
                    color: AppColorsPalette.gray500,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
