import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class HomeBiometricCard extends StatelessWidget {
  final bool isEnabled;
  final ValueChanged<bool> onToggle;

  const HomeBiometricCard({
    required this.isEnabled,
    required this.onToggle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColorsPalette.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.fingerprint_rounded,
            size: 24,
            color: AppColorsPalette.black,
          ),
          const SizedBox(width: 14),
          Text(
            'Biometric fallback',
            style: AppTypography.medium.copyWith(
              fontSize: 15,
              color: AppColorsPalette.black,
            ),
          ),
          const Spacer(),
          Transform.scale(
            scale: 0.85,
            child: CupertinoSwitch(
              value: isEnabled,
              activeTrackColor: AppColorsPalette.black,
              onChanged: onToggle,
            ),
          ),
        ],
      ),
    );
  }
}
