import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class CommonPinKeypad extends StatelessWidget {
  final ValueChanged<String> onDigitTap;
  final VoidCallback onBackspaceTap;
  final VoidCallback? onBiometricTap;

  const CommonPinKeypad({
    super.key,
    required this.onDigitTap,
    required this.onBackspaceTap,
    this.onBiometricTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildNumpadRow(['1', '2', '3']),
        const SizedBox(height: 16),
        _buildNumpadRow(['4', '5', '6']),
        const SizedBox(height: 16),
        _buildNumpadRow(['7', '8', '9']),
        const SizedBox(height: 16),
        _buildNumpadBottomRow(),
      ],
    );
  }

  Widget _buildNumpadRow(List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map(_buildDigitButton).toList(),
    );
  }

  Widget _buildNumpadBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (onBiometricTap != null)
          SizedBox(
            width: 72,
            height: 72,
            child: Center(
              child: InkWell(
                borderRadius: BorderRadius.circular(28),
                onTap: onBiometricTap,
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: AppColorsPalette.gray50,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColorsPalette.gray200,
                      width: 1,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.fingerprint_rounded,
                      color: AppColorsPalette.black,
                      size: 26,
                    ),
                  ),
                ),
              ),
            ),
          )
        else
          const SizedBox(width: 72, height: 72),
        _buildDigitButton('0'),
        InkWell(
          borderRadius: BorderRadius.circular(36),
          onTap: onBackspaceTap,
          child: const SizedBox(
            width: 72,
            height: 72,
            child: Icon(
              Icons.backspace_outlined,
              color: AppColorsPalette.black,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDigitButton(String digit) {
    return InkWell(
      borderRadius: BorderRadius.circular(36),
      onTap: () => onDigitTap(digit),
      child: Container(
        width: 72,
        height: 72,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColorsPalette.gray50,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColorsPalette.gray200,
            width: 1.0,
          ),
        ),
        child: Text(
          digit,
          style: AppTypography.semiBold.copyWith(
            fontSize: 24,
            color: AppColorsPalette.black,
          ),
        ),
      ),
    );
  }
}
