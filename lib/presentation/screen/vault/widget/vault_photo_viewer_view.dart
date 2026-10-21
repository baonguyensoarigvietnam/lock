import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_media_viewer_bottom_bar.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

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
        CommonAppBar.titledBack(
          onBack: onBack,
          title: fileName,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
        CommonMediaViewerBottomBar(
          onRestoreConfirmed: onRestore,
          onDeleteConfirmed: onDelete,
          onInfo: onInfo,
        ),
      ],
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
