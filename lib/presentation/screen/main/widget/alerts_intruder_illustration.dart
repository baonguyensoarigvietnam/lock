import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class AlertsIntruderIllustration extends StatelessWidget {
  final bool hasPhoto;
  final bool isLarge;

  const AlertsIntruderIllustration({
    this.hasPhoto = true,
    this.isLarge = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!hasPhoto) {
      if (isLarge) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFEEEEEE),
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
                'No photo captured',
                textAlign: TextAlign.center,
                style: AppTypography.bold.copyWith(
                  fontSize: 17,
                  color: AppColorsPalette.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'The security system failed to\ninitialize the camera during this\nevent.',
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
        color: const Color(0xFFEBEBEB),
        child: const Center(
          child: Icon(
            Icons.camera_alt_outlined,
            size: 32,
            color: AppColorsPalette.gray500,
          ),
        ),
      );
    }

    final phoneWidth = isLarge ? 176.0 : 68.0;
    final phoneHeight = isLarge ? 264.0 : 92.0;
    final borderRadius = isLarge ? 26.0 : 12.0;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A1A1A),
            Color(0xFF0A0A0A),
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: phoneWidth,
          height: phoneHeight,
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: const Color(0xFF525252),
              width: isLarge ? 3.0 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColorsPalette.black.withValues(alpha: 0.6),
                blurRadius: isLarge ? 16 : 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.all(isLarge ? 5 : 2),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
              borderRadius - (isLarge ? 4 : 2),
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Inner screen diagonal dramatic light gradient
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFD4D4D4),
                        Color(0xFF525252),
                        Color(0xFF121212),
                      ],
                      stops: [0.0, 0.45, 0.9],
                    ),
                  ),
                ),

                // Top notch
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: phoneWidth * 0.44,
                    height: isLarge ? 12 : 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F0F0F),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(isLarge ? 8 : 3),
                      ),
                    ),
                  ),
                ),

                // Hooded Intruder Silhouette
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomPaint(
                    size: Size(phoneWidth, phoneHeight * 0.84),
                    painter: _HoodedIntruderPainter(isLarge: isLarge),
                  ),
                ),

                // Bottom lock icon indicator inside phone frame
                Positioned(
                  bottom: isLarge ? 14 : 6,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: isLarge ? 18 : 8,
                      height: isLarge ? 18 : 8,
                      decoration: BoxDecoration(
                        color: AppColorsPalette.white.withValues(alpha: 0.18),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_rounded,
                        size: isLarge ? 10 : 5,
                        color: AppColorsPalette.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ),
                ),

                // Home indicator bar inside phone frame
                Positioned(
                  bottom: isLarge ? 5 : 2,
                  left: phoneWidth * 0.28,
                  right: phoneWidth * 0.28,
                  child: Container(
                    height: isLarge ? 2.5 : 1.2,
                    decoration: BoxDecoration(
                      color: AppColorsPalette.white.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],
            ),
          ),
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

class _HoodedIntruderPainter extends CustomPainter {
  final bool isLarge;

  const _HoodedIntruderPainter({required this.isLarge});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Shoulders & Jacket
    final bodyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF3A3A3A),
          Color(0xFF141414),
          Color(0xFF080808),
        ],
      ).createShader(Rect.fromLTWH(0, h * 0.45, w, h * 0.55));

    final bodyPath = Path()
      ..moveTo(w * 0.06, h)
      ..quadraticBezierTo(w * 0.08, h * 0.55, w * 0.32, h * 0.48)
      ..lineTo(w * 0.68, h * 0.48)
      ..quadraticBezierTo(w * 0.92, h * 0.55, w * 0.94, h)
      ..close();
    canvas.drawPath(bodyPath, bodyPaint);

    // Outer Hood
    final hoodPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF5A5A5A),
          Color(0xFF262626),
          Color(0xFF121212),
        ],
      ).createShader(Rect.fromLTWH(w * 0.24, h * 0.06, w * 0.52, h * 0.5));

    final hoodRect = Rect.fromCenter(
      center: Offset(w * 0.5, h * 0.31),
      width: w * 0.46,
      height: h * 0.46,
    );
    canvas.drawOval(hoodRect, hoodPaint);

    // Inner Dark Face / Mask Shadow
    final facePaint = Paint()..color = const Color(0xFF0B0B0B);
    final faceRect = Rect.fromCenter(
      center: Offset(w * 0.5, h * 0.33),
      width: w * 0.32,
      height: h * 0.34,
    );
    canvas.drawOval(faceRect, facePaint);

    // Subtle eye-slit highlight
    final eyePaint = Paint()
      ..color = const Color(0xFF737373).withValues(alpha: 0.55)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.44, h * 0.29),
        width: w * 0.06,
        height: h * 0.018,
      ),
      eyePaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.56, h * 0.29),
        width: w * 0.06,
        height: h * 0.018,
      ),
      eyePaint,
    );

    // Small handheld phone in intruder's hand
    final miniPhonePaint = Paint()..color = const Color(0xFF0E0E0E);
    final miniPhoneBorder = Paint()
      ..color = const Color(0xFF525252)
      ..style = PaintingStyle.stroke
      ..strokeWidth = isLarge ? 1.4 : 0.8;

    final miniPhoneRRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(w * 0.48, h * 0.62),
        width: w * 0.22,
        height: h * 0.24,
      ),
      Radius.circular(isLarge ? 4 : 2),
    );
    canvas.drawRRect(miniPhoneRRect, miniPhonePaint);
    canvas.drawRRect(miniPhoneRRect, miniPhoneBorder);
  }

  @override
  bool shouldRepaint(covariant _HoodedIntruderPainter oldDelegate) =>
      oldDelegate.isLarge != isLarge;
}
