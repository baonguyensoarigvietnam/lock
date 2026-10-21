import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class LockScreenResetSecurityView extends StatelessWidget {
  final bool isConfirmed;
  final VoidCallback onToggleConfirmed;
  final VoidCallback onReset;
  final VoidCallback onCancel;

  const LockScreenResetSecurityView({
    super.key,
    required this.isConfirmed,
    required this.onToggleConfirmed,
    required this.onReset,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const SizedBox(height: 8),
          // Warning Icon Circle
          Container(
            width: 68,
            height: 68,
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
                Icons.warning_amber_rounded,
                size: 32,
                color: AppColorsPalette.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.resetSecurityQuestionTitle,
            textAlign: TextAlign.center,
            style: AppTypography.bold.copyWith(
              fontSize: 24,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              l10n.resetSecurityWarningDesc,
              textAlign: TextAlign.center,
              style: AppTypography.regular.copyWith(
                fontSize: 15,
                color: AppColorsPalette.gray600,
                height: 1.45,
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Confirmation Checkbox Box
          InkWell(
            onTap: onToggleConfirmed,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              decoration: BoxDecoration(
                color: AppColorsPalette.gray50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColorsPalette.gray200,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: isConfirmed
                          ? AppColorsPalette.black
                          : AppColorsPalette.white,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: isConfirmed
                            ? AppColorsPalette.black
                            : AppColorsPalette.gray300,
                        width: 1.2,
                      ),
                    ),
                    child: isConfirmed
                        ? const Icon(
                            Icons.check_rounded,
                            size: 15,
                            color: AppColorsPalette.white,
                          )
                        : null,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      l10n.resetSecurityConfirmCheckbox,
                      style: AppTypography.regular.copyWith(
                        fontSize: 14,
                        color: AppColorsPalette.black,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Reset Button (disabled gray until confirmed)
          CommonButton.filled(
            text: l10n.resetButton,
            height: 50,
            cornerRadius: 10,
            backgroundColor: AppColorsPalette.black,
            textColor: AppColorsPalette.white,
            disabledBackgroundColor: AppColorsPalette.gray100,
            disabledTextColor: AppColorsPalette.gray500,
            textStyle: AppTypography.semiBold.copyWith(
              fontSize: 15,
              color: isConfirmed
                  ? AppColorsPalette.white
                  : AppColorsPalette.gray500,
            ),
            onPressed: isConfirmed ? onReset : null,
          ),
          const SizedBox(height: 10),

          // Cancel Button
          CommonButton.outline(
            text: l10n.cancelButton,
            height: 50,
            cornerRadius: 10,
            backgroundColor: AppColorsPalette.white,
            borderColor: AppColorsPalette.gray200,
            borderWidth: 1,
            textColor: AppColorsPalette.black,
            textStyle: AppTypography.semiBold.copyWith(
              fontSize: 15,
              color: AppColorsPalette.black,
            ),
            onPressed: onCancel,
          ),
        ],
      ),
    );
  }
}
