import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class AlertsTabContent extends StatelessWidget {
  const AlertsTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPalette.white,
      appBar: AppBar(
        backgroundColor: AppColorsPalette.white,
        elevation: 0,
        title: Text(
          'Intruder Alerts',
          style: AppTypography.bold.copyWith(
            fontSize: 20,
            color: AppColorsPalette.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                  width: 1.2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.shield_outlined,
                      color: AppColorsPalette.black,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Break-in Detection Active',
                          style: AppTypography.bold.copyWith(
                            fontSize: 15.5,
                            color: AppColorsPalette.black,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Front camera snaps photo after 3 failed unlock attempts',
                          style: AppTypography.regular.copyWith(
                            fontSize: 12.5,
                            color: AppColorsPalette.gray600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Recent Activity (2)',
              style: AppTypography.bold.copyWith(
                fontSize: 17,
                color: AppColorsPalette.black,
              ),
            ),
            const SizedBox(height: 14),
            _buildAlertItem(
              title: 'Failed PIN attempt (3x)',
              subtitle: 'Facebook • Today at 10:42 AM',
            ),
            const SizedBox(height: 12),
            _buildAlertItem(
              title: 'Incorrect Pattern (3x)',
              subtitle: 'Photos • Yesterday at 08:15 PM',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertItem({
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColorsPalette.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: Color(0xFFDC2626),
              size: 22,
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
                    fontSize: 14.5,
                    color: AppColorsPalette.black,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: AppTypography.regular.copyWith(
                    fontSize: 12.5,
                    color: AppColorsPalette.gray600,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF9CA3AF),
            size: 20,
          ),
        ],
      ),
    );
  }
}
