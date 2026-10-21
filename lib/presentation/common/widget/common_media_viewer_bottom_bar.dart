import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/dialog_utility.dart';

/// Shared bottom toolbar (Restore | Delete | Info) for Vault photo and video viewers.
class CommonMediaViewerBottomBar extends StatelessWidget {
  final VoidCallback onRestoreConfirmed;
  final VoidCallback onDeleteConfirmed;
  final VoidCallback onInfo;

  const CommonMediaViewerBottomBar({
    super.key,
    required this.onRestoreConfirmed,
    required this.onDeleteConfirmed,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: AppColorsPalette.gray50,
        border: Border(
          top: BorderSide(
            color: AppColorsPalette.gray200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildActionItem(
            icon: Icons.restore_rounded,
            label: 'Restore',
            onTap: () {
              DialogUtility.showRestoreToGalleryBottomSheet(
                context: context,
                onRestore: onRestoreConfirmed,
              );
            },
          ),
          _buildActionItem(
            icon: Icons.delete_outline_rounded,
            label: 'Delete',
            onTap: () {
              DialogUtility.showDeleteFromVaultBottomSheet(
                context: context,
                onDelete: onDeleteConfirmed,
              );
            },
          ),
          _buildActionItem(
            icon: Icons.info_outline_rounded,
            label: 'Info',
            onTap: onInfo,
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: AppColorsPalette.gray700,
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppTypography.medium.copyWith(
                fontSize: 11.5,
                color: AppColorsPalette.gray600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
