import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';

class CommonPinDots extends StatelessWidget {
  final int pinLength;
  final int filledCount;

  const CommonPinDots({
    super.key,
    this.pinLength = 6,
    required this.filledCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pinLength, (index) {
        final isFilled = index < filledCount;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 7),
          width: 13,
          height: 13,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isFilled ? AppColorsPalette.black : AppColorsPalette.white,
            border: Border.all(
              color: isFilled
                  ? AppColorsPalette.black
                  : AppColorsPalette.gray300,
              width: 1.5,
            ),
          ),
        );
      }),
    );
  }
}
