import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/dialog_utility.dart';

class VaultPhotoViewerView extends StatelessWidget {
  final String fileName;
  final VoidCallback onBack;
  final VoidCallback onRestore;
  final VoidCallback onDelete;
  final VoidCallback onInfo;

  const VaultPhotoViewerView({
    super.key,
    this.fileName = 'IMG_20240315.jpg',
    required this.onBack,
    required this.onRestore,
    required this.onDelete,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top App Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: AppColorsPalette.black,
                  size: 22,
                ),
                onPressed: onBack,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    fileName,
                    style: AppTypography.bold.copyWith(
                      fontSize: 17,
                      color: AppColorsPalette.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Main Image Canvas Preview
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColorsPalette.gray150,
                border: Border.all(
                  color: AppColorsPalette.gray200,
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _LargeWireframeCrossPainter(),
                    ),
                  ),
                  const Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 96,
                      color: AppColorsPalette.gray350,
                    ),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColorsPalette.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '100%',
                        style: AppTypography.medium.copyWith(
                          fontSize: 12,
                          color: AppColorsPalette.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Bottom Action Toolbar (Restore | Delete | Info)
        Container(
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
                    onRestore: onRestore,
                  );
                },
              ),
              _buildActionItem(
                icon: Icons.delete_outline_rounded,
                label: 'Delete',
                onTap: () {
                  DialogUtility.showDeleteFromVaultBottomSheet(
                    context: context,
                    onDelete: onDelete,
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
        ),
      ],
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

class _LargeWireframeCrossPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColorsPalette.gray250
      ..strokeWidth = 1.0;

    final topOffset = size.height * 0.14;
    final bottomOffset = size.height * 0.86;

    canvas.drawLine(
      Offset(0, topOffset),
      Offset(size.width, bottomOffset),
      paint,
    );
    canvas.drawLine(
      Offset(size.width, topOffset),
      Offset(0, bottomOffset),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
