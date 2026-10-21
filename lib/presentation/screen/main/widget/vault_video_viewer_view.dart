import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/dialog_utility.dart';

class VaultVideoViewerView extends StatefulWidget {
  final String fileName;
  final VoidCallback onBack;
  final VoidCallback onRestoreConfirmed;
  final VoidCallback onDeleteConfirmed;
  final VoidCallback onInfo;

  const VaultVideoViewerView({
    super.key,
    this.fileName = 'VID_20231024_0842.mp4',
    required this.onBack,
    required this.onRestoreConfirmed,
    required this.onDeleteConfirmed,
    required this.onInfo,
  });

  @override
  State<VaultVideoViewerView> createState() => _VaultVideoViewerViewState();
}

class _VaultVideoViewerViewState extends State<VaultVideoViewerView> {
  bool _isPlaying = false;

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
                onPressed: widget.onBack,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    widget.fileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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

        const Spacer(),

        // Video Player Container
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            width: double.infinity,
            height: 215,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColorsPalette.gray700,
                  AppColorsPalette.gray550,
                  AppColorsPalette.gray900,
                ],
                stops: [0.0, 0.55, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Subtle diagonal highlight stripe
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: CustomPaint(
                      painter: _VideoBeamPainter(),
                    ),
                  ),
                ),
                // Center Play / Pause Button
                Center(
                  child: GestureDetector(
                    onTap: () => setState(() => _isPlaying = !_isPlaying),
                    child: Container(
                      width: 68,
                      height: 68,
                      decoration: const BoxDecoration(
                        color: AppColorsPalette.gray200,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          _isPlaying
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          size: 38,
                          color: AppColorsPalette.black,
                        ),
                      ),
                    ),
                  ),
                ),
                // Bottom Scrubber & Timestamps
                Positioned(
                  left: 14,
                  right: 14,
                  bottom: 12,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColorsPalette.gray300,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '03:24',
                          style: AppTypography.semiBold.copyWith(
                            fontSize: 11.5,
                            color: AppColorsPalette.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2),
                          child: SizedBox(
                            height: 3.5,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 45,
                                  child: Container(
                                    color: AppColorsPalette.black,
                                  ),
                                ),
                                Expanded(
                                  flex: 55,
                                  child: Container(
                                    color: AppColorsPalette.gray300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '07:52',
                        style: AppTypography.medium.copyWith(
                          fontSize: 11.5,
                          color: AppColorsPalette.gray500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const Spacer(),

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
                    onRestore: widget.onRestoreConfirmed,
                  );
                },
              ),
              _buildActionItem(
                icon: Icons.delete_outline_rounded,
                label: 'Delete',
                onTap: () {
                  DialogUtility.showDeleteFromVaultBottomSheet(
                    context: context,
                    onDelete: widget.onDeleteConfirmed,
                  );
                },
              ),
              _buildActionItem(
                icon: Icons.info_outline_rounded,
                label: 'Info',
                onTap: widget.onInfo,
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

class _VideoBeamPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColorsPalette.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width * 0.55, 0)
      ..lineTo(size.width * 0.9, 0)
      ..lineTo(size.width * 0.45, size.height)
      ..lineTo(size.width * 0.15, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
