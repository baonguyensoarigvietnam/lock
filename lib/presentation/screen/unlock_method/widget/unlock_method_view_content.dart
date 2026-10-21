import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_button.dart';
import 'package:applock/presentation/screen/unlock_method/unlock_method_navigator.dart';
import 'package:applock/presentation/screen/unlock_method/view_model/unlock_method_state.dart';
import 'package:applock/presentation/screen/unlock_method/view_model/unlock_method_view_model.dart';
import 'package:applock/presentation/screen/unlock_method/widget/unlock_method_item_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class UnlockMethodViewContent extends StatelessWidget {
  const UnlockMethodViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColorsPalette.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // Top Title
              const CommonAppBar.brand(),
              const SizedBox(height: 32),
              // Heading
              Text(
                l10n.unlockMethodTitle,
                style: AppTypography.bold.copyWith(
                  fontSize: 24,
                  color: AppColorsPalette.black,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.unlockMethodSubtitle,
                style: AppTypography.regular.copyWith(
                  fontSize: 15,
                  color: AppColorsPalette.gray600,
                ),
              ),
              const SizedBox(height: 28),
              // Options
              BlocBuilder<UnlockMethodViewModel, UnlockMethodState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      UnlockMethodItemCard(
                        icon: const Icon(
                          Icons.dialpad_rounded,
                          size: 22,
                          color: AppColorsPalette.black,
                        ),
                        title: l10n.createPinTitle,
                        subtitle: l10n.createPinSubtitle,
                        isSelected:
                            state.selectedMethod == UnlockMethodType.pin,
                        onTap: () {
                          context
                              .read<UnlockMethodViewModel>()
                              .selectMethod(UnlockMethodType.pin);
                        },
                      ),
                      const SizedBox(height: 14),
                      UnlockMethodItemCard(
                        icon: const Icon(
                          Icons.gesture_rounded,
                          size: 22,
                          color: AppColorsPalette.black,
                        ),
                        title: l10n.drawPatternTitle,
                        subtitle: l10n.drawPatternSubtitle,
                        isSelected:
                            state.selectedMethod == UnlockMethodType.pattern,
                        onTap: () {
                          context
                              .read<UnlockMethodViewModel>()
                              .selectMethod(UnlockMethodType.pattern);
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 24),
              // Warning box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColorsPalette.gray100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Icons.warning_rounded,
                        color: AppColorsPalette.gray700,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        l10n.unlockMethodWarning,
                        style: AppTypography.regular.copyWith(
                          fontSize: 13.5,
                          color: AppColorsPalette.gray700,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Bottom Continue Button
              BlocBuilder<UnlockMethodViewModel, UnlockMethodState>(
                builder: (context, state) {
                  return CommonButton.filled(
                    text: l10n.continueButton,
                    backgroundColor: state.canContinue
                        ? AppColorsPalette.black
                        : AppColorsPalette.gray500,
                    onPressed: state.canContinue
                        ? () {
                            final nav = context.read<UnlockMethodNavigator>();
                            if (state.selectedMethod == UnlockMethodType.pattern) {
                              nav.goToSetPattern();
                            } else {
                              nav.goToSetPasscode();
                            }
                          }
                        : null,
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
