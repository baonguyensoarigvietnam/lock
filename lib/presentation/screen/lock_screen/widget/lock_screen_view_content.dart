import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/screen/lock_screen/lock_screen_navigator.dart';
import 'package:applock/presentation/screen/lock_screen/view_model/lock_screen_state.dart';
import 'package:applock/presentation/screen/lock_screen/view_model/lock_screen_view_model.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class LockScreenViewContent extends StatefulWidget {
  final String? appName;

  const LockScreenViewContent({super.key, this.appName});

  @override
  State<LockScreenViewContent> createState() => _LockScreenViewContentState();
}

class _LockScreenViewContentState extends State<LockScreenViewContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LockScreenViewModel>().init(appName: widget.appName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LockScreenViewModel, LockScreenState>(
      listenWhen: (prev, curr) => !prev.isUnlocked && curr.isUnlocked,
      listener: (context, state) {
        context.read<LockScreenNavigator>().unlockSuccess();
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: AppColorsPalette.slate900,
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 36),
                // Lock Icon and App name
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: AppColorsPalette.primary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColorsPalette.primary.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    Icons.lock_outline_rounded,
                    size: 34,
                    color: AppColorsPalette.primary,
                  ),
                ),
                const SizedBox(height: 16),
                BlocBuilder<LockScreenViewModel, LockScreenState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Text(
                          state.targetAppName ?? 'Ứng dụng đã bị khoá',
                          style: AppTypography.bold.copyWith(
                            fontSize: 22,
                            color: AppColorsPalette.white,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Nhập mã PIN để tiếp tục',
                          style: AppTypography.regular.copyWith(
                            fontSize: 14,
                            color: AppColorsPalette.gray400,
                          ),
                        ),
                        const SizedBox(height: 28),
                        // PIN dots
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            final isFilled = index < state.currentInput.length;
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isFilled
                                    ? AppColorsPalette.primary
                                    : AppColorsPalette.slate800,
                                border: Border.all(
                                  color: isFilled
                                      ? AppColorsPalette.primary
                                      : AppColorsPalette.gray600,
                                  width: 1.5,
                                ),
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 14),
                        if (state.errorMessage != null)
                          Text(
                            state.errorMessage!,
                            style: AppTypography.medium.copyWith(
                              color: AppColorsPalette.red500,
                              fontSize: 13,
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const Spacer(),
                // Keypad
                _buildKeypad(context),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKeypad(BuildContext context) {
    return Column(
      children: [
        _buildRow(context, ['1', '2', '3']),
        const SizedBox(height: 16),
        _buildRow(context, ['4', '5', '6']),
        const SizedBox(height: 16),
        _buildRow(context, ['7', '8', '9']),
        const SizedBox(height: 16),
        _buildBottomRow(context),
      ],
    );
  }

  Widget _buildRow(BuildContext context, List<String> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits.map((digit) => _buildKey(context, digit)).toList(),
    );
  }

  Widget _buildBottomRow(BuildContext context) {
    return BlocBuilder<LockScreenViewModel, LockScreenState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Biometric button (if available)
            if (state.isBiometricAvailable)
              InkWell(
                borderRadius: BorderRadius.circular(36),
                onTap: () =>
                    context.read<LockScreenViewModel>().authenticateWithBiometric(),
                child: const SizedBox(
                  width: 72,
                  height: 72,
                  child: Icon(
                    Icons.fingerprint_rounded,
                    color: AppColorsPalette.primary,
                    size: 36,
                  ),
                ),
              )
            else
              const SizedBox(width: 72, height: 72),

            _buildKey(context, '0'),

            // Backspace button
            InkWell(
              borderRadius: BorderRadius.circular(36),
              onTap: () => context.read<LockScreenViewModel>().deleteDigit(),
              child: const SizedBox(
                width: 72,
                height: 72,
                child: Icon(
                  Icons.backspace_outlined,
                  color: AppColorsPalette.gray400,
                  size: 26,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildKey(BuildContext context, String digit) {
    return InkWell(
      borderRadius: BorderRadius.circular(36),
      onTap: () => context.read<LockScreenViewModel>().appendDigit(digit),
      child: Container(
        width: 72,
        height: 72,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColorsPalette.slate800.withValues(alpha: 0.6),
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColorsPalette.gray700.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Text(
          digit,
          style: AppTypography.semiBold.copyWith(
            fontSize: 26,
            color: AppColorsPalette.white,
          ),
        ),
      ),
    );
  }
}
