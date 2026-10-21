import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class LockScreenBiometricView extends StatelessWidget {
  final String? statusText;
  final VoidCallback onRetryBiometric;
  final VoidCallback onUsePinInstead;

  const LockScreenBiometricView({
    super.key,
    this.statusText,
    required this.onRetryBiometric,
    required this.onUsePinInstead,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(flex: 2),
          // Large Fingerprint Circle
          GestureDetector(
            onTap: onRetryBiometric,
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: 112,
              height: 112,
              decoration: BoxDecoration(
                color: AppColorsPalette.gray100,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColorsPalette.gray200,
                  width: 1,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.fingerprint_rounded,
                  size: 48,
                  color: AppColorsPalette.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            'Use biometric unlock',
            textAlign: TextAlign.center,
            style: AppTypography.bold.copyWith(
              fontSize: 24,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Unlock with device authentication.',
            textAlign: TextAlign.center,
            style: AppTypography.regular.copyWith(
              fontSize: 15,
              color: AppColorsPalette.gray500,
            ),
          ),
          const SizedBox(height: 24),
          if (statusText != null)
            Text(
              statusText!,
              textAlign: TextAlign.center,
              style: AppTypography.semiBold.copyWith(
                fontSize: 12,
                letterSpacing: 0.6,
                color: AppColorsPalette.gray500,
              ),
            ),
          const Spacer(flex: 3),
          CommonButton.filled(
            text: 'Use PIN instead',
            height: 52,
            cornerRadius: 12,
            backgroundColor: AppColorsPalette.black,
            textColor: AppColorsPalette.white,
            textStyle: AppTypography.semiBold.copyWith(
              fontSize: 15,
              color: AppColorsPalette.white,
            ),
            onPressed: onUsePinInstead,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
