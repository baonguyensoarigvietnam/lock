import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

/// Shows the captured intruder photo, or a "no photo captured" placeholder
/// when no photo exists (or the file can no longer be read).
class AlertsIntruderIllustration extends StatelessWidget {
  final String? photoPath;
  final bool isLarge;

  const AlertsIntruderIllustration({
    this.photoPath,
    this.isLarge = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final path = photoPath;
    if (path == null || path.isEmpty) {
      return _buildNoPhoto(context);
    }
    return Container(
      color: AppColorsPalette.gray950,
      child: Image.file(
        File(path),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        gaplessPlayback: true,
        cacheWidth: isLarge ? null : 320,
        errorBuilder: (context, _, _) => _buildNoPhoto(context),
      ),
    );
  }

  Widget _buildNoPhoto(BuildContext context) {
    final l10n = context.l10n;
    if (isLarge) {
      return Container(
        decoration: BoxDecoration(
          color: AppColorsPalette.gray150,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColorsPalette.gray200,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomPaint(
              painter: _DashedCircleBorderPainter(
                color: AppColorsPalette.gray300,
              ),
              child: Container(
                width: 84,
                height: 84,
                decoration: const BoxDecoration(
                  color: AppColorsPalette.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.no_photography_outlined,
                    size: 34,
                    color: AppColorsPalette.gray500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              l10n.noPhotoCapturedTitle,
              textAlign: TextAlign.center,
              style: AppTypography.bold.copyWith(
                fontSize: 17,
                color: AppColorsPalette.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.noPhotoCapturedDesc,
              textAlign: TextAlign.center,
              style: AppTypography.regular.copyWith(
                fontSize: 13.5,
                color: AppColorsPalette.gray500,
                height: 1.4,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      color: AppColorsPalette.gray150,
      child: const Center(
        child: Icon(
          Icons.camera_alt_outlined,
          size: 32,
          color: AppColorsPalette.gray500,
        ),
      ),
    );
  }
}

class _DashedCircleBorderPainter extends CustomPainter {
  final Color color;

  const _DashedCircleBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final radius = (math.min(size.width, size.height) / 2) + 1;
    final center = Offset(size.width / 2, size.height / 2);
    const dashCount = 36;
    const step = (2 * math.pi) / dashCount;

    for (var i = 0; i < dashCount; i++) {
      final startAngle = i * step;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        step * 0.55,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedCircleBorderPainter oldDelegate) =>
      oldDelegate.color != color;
}
