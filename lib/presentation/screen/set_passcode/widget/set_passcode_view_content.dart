import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/common_pin_dots.dart';
import 'package:applock/presentation/common/widget/common_pin_keypad.dart';
import 'package:applock/presentation/screen/set_passcode/set_passcode_navigator.dart';
import 'package:applock/presentation/screen/set_passcode/view_model/set_passcode_state.dart';
import 'package:applock/presentation/screen/set_passcode/view_model/set_passcode_view_model.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class SetPasscodeViewContent extends StatelessWidget {
  const SetPasscodeViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetPasscodeViewModel, SetPasscodeState>(
      listenWhen: (previous, current) =>
          !previous.isCompleted && current.isCompleted,
      listener: (context, state) {
        context.read<SetPasscodeNavigator>().goToEnableBiometric();
      },
      child: Scaffold(
        backgroundColor: AppColorsPalette.white,
        body: SafeArea(
          child: Column(
            children: [
              // Top Bar with back button
              CommonAppBar.back(
                leadingIconSize: 26,
                onBack: () {
                  final vm = context.read<SetPasscodeViewModel>();
                  if (vm.state.step == SetPasscodeStep.confirm) {
                    vm.handleBack();
                  } else {
                    context.read<SetPasscodeNavigator>().goBack();
                  }
                },
              ),
              const SizedBox(height: 16),
              // Heading & Subtitle
              BlocBuilder<SetPasscodeViewModel, SetPasscodeState>(
                builder: (context, state) {
                  final isConfirm = state.step == SetPasscodeStep.confirm;
                  final hasError = state.validationError != null;

                  final String title =
                      isConfirm ? 'Confirm your PIN' : 'Create your PIN';
                  final String subtitle = hasError
                      ? state.validationError!
                      : (isConfirm
                          ? 'Re-enter your PIN to confirm.'
                          : 'Use this PIN to access your protected content.');

                  return Column(
                    children: [
                      Text(
                        title,
                        style: AppTypography.bold.copyWith(
                          fontSize: 24,
                          color: AppColorsPalette.black,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: AppTypography.regular.copyWith(
                            fontSize: 15,
                            color: AppColorsPalette.gray600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      // 6 PIN Dots (Common Widget)
                      CommonPinDots(
                        pinLength: SetPasscodeViewModel.pinLength,
                        filledCount: state.currentInput.length,
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              // Numpad (Common Widget)
              CommonPinKeypad(
                onDigitTap: (digit) =>
                    context.read<SetPasscodeViewModel>().appendDigit(digit),
                onBackspaceTap: () =>
                    context.read<SetPasscodeViewModel>().deleteDigit(),
              ),
              const Spacer(),
              // Bottom switch to Pattern
              GestureDetector(
                onTap: () {
                  context.read<SetPasscodeNavigator>().goToPattern();
                },
                child: Text(
                  'Use pattern instead',
                  style: AppTypography.medium.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
