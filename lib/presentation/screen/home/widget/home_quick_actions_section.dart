import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class HomeQuickActionsSection extends StatelessWidget {
  final VoidCallback onLockAppsTap;
  final VoidCallback onVaultTap;
  final VoidCallback onThemesTap;
  final VoidCallback onAlertsTap;

  const HomeQuickActionsSection({
    required this.onLockAppsTap,
    required this.onVaultTap,
    required this.onThemesTap,
    required this.onAlertsTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: AppTypography.bold.copyWith(
            fontSize: 18,
            color: AppColorsPalette.black,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.grid_view_rounded,
                title: 'Lock Apps',
                onTap: onLockAppsTap,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildActionCard(
                icon: Icons.photo_library_outlined,
                title: 'Vault',
                onTap: onVaultTap,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                icon: Icons.edit_outlined,
                title: 'Themes',
                onTap: onThemesTap,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _buildActionCard(
                icon: Icons.shield_outlined,
                title: 'Alerts',
                onTap: onAlertsTap,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColorsPalette.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 104,
          decoration: BoxDecoration(
            color: AppColorsPalette.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColorsPalette.gray200,
              width: 1.2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 26,
                color: AppColorsPalette.black,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: AppTypography.bold.copyWith(
                  fontSize: 14.5,
                  color: AppColorsPalette.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
