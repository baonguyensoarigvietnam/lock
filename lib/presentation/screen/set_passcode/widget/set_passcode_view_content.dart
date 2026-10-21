import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColorsPalette.black,
                    size: 26,
                  ),
                  onPressed: () {
                    final vm = context.read<SetPasscodeViewModel>();
                    if (vm.state.step == SetPasscodeStep.confirm) {
                      vm.handleBack();
                    } else {
                      context.read<SetPasscodeNavigator>().goBack();
                    }
                  },
                ),
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
                            color: hasError
                                ? AppColorsPalette.gray600
                                : AppColorsPalette.gray600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 36),
                      // 6 PIN Dots
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(SetPasscodeViewModel.pinLength,
                            (index) {
                          final isFilled = index < state.currentInput.length;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 7),
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isFilled
                                  ? AppColorsPalette.black
                                  : AppColorsPalette.white,
                              border: Border.all(
                                color: isFilled
                                    ? AppColorsPalette.black
                                    : const Color(0xFFD1D5DB),
                                width: 1.5,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),
              // Numpad
              _buildNumpad(context),
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

  Widget _buildNumpad(BuildContext context) {
    return Column(
      children: [
        _buildNumpadRow(context, ['1', '2', '3']),
        const SizedBox(height: 16),
        _buildNumpadRow(context, ['4', '5', '6']),
        const SizedBox(height: 16),
        _buildNumpadRow(context, ['7', '8', '9']),
        const SizedBox(height: 16),
        _buildNumpadBottomRow(context),
      ],
    );
  }

  Widget _buildNumpadRow(BuildContext context, List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map((digit) {
        return _buildDigitButton(context, digit);
      }).toList(),
    );
  }

  Widget _buildNumpadBottomRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(width: 72, height: 72),
        _buildDigitButton(context, '0'),
        InkWell(
          borderRadius: BorderRadius.circular(36),
          onTap: () => context.read<SetPasscodeViewModel>().deleteDigit(),
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

  Widget _buildDigitButton(BuildContext context, String digit) {
    return InkWell(
      borderRadius: BorderRadius.circular(36),
      onTap: () => context.read<SetPasscodeViewModel>().appendDigit(digit),
      child: Container(
        width: 72,
        height: 72,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1.0,
          ),
        ),
        child: Text(
          digit,
          style: AppTypography.medium.copyWith(
            fontSize: 26,
            color: AppColorsPalette.black,
          ),
        ),
      ),
    );
  }
}
