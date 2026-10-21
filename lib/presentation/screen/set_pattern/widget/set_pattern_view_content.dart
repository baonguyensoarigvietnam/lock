import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/pattern_lock_grid.dart';
import 'package:applock/presentation/screen/set_pattern/set_pattern_navigator.dart';
import 'package:applock/presentation/screen/set_pattern/view_model/set_pattern_state.dart';
import 'package:applock/presentation/screen/set_pattern/view_model/set_pattern_view_model.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class SetPatternViewContent extends StatelessWidget {
  const SetPatternViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetPatternViewModel, SetPatternState>(
      listenWhen: (previous, current) =>
          !previous.isCompleted && current.isCompleted,
      listener: (context, state) {
        context.read<SetPatternNavigator>().goToEnableBiometric();
      },
      child: Scaffold(
        backgroundColor: AppColorsPalette.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── Back button ──────────────────────────────────────────────
              CommonAppBar.back(
                leadingIconSize: 26,
                onBack: () {
                  final vm = context.read<SetPatternViewModel>();
                  if (vm.state.step == SetPatternStep.confirm) {
                    vm.handleBack();
                  } else {
                    context.read<SetPatternNavigator>().goBack();
                  }
                },
              ),
              const SizedBox(height: 16),

              // ── Title & Subtitle ─────────────────────────────────────────
              BlocBuilder<SetPatternViewModel, SetPatternState>(
                builder: (context, state) {
                  final isConfirm = state.step == SetPatternStep.confirm;
                  final hasError = state.validationError != null;

                  final String title = isConfirm
                      ? 'Confirm your pattern'
                      : 'Draw an unlock pattern';

                  final String subtitle = hasError
                      ? state.validationError!
                      : (isConfirm
                          ? 'Draw your pattern again to confirm.'
                          : 'Connect at least 4 dots.');

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
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: AppTypography.regular.copyWith(
                          fontSize: 15,
                          color: hasError
                              ? AppColorsPalette.gray500
                              : AppColorsPalette.gray500,
                        ),
                      ),
                    ],
                  );
                },
              ),

              const Spacer(),

              // ── Pattern Grid ─────────────────────────────────────────────
              BlocBuilder<SetPatternViewModel, SetPatternState>(
                builder: (context, state) {
                  final hasError = state.validationError != null;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 48),
                    child: PatternLockGrid(
                      isError: hasError,
                      onPatternStart: () {
                        context.read<SetPatternViewModel>().resetCurrentPattern();
                      },
                      onPatternComplete: (dots) {
                        context
                            .read<SetPatternViewModel>()
                            .onPatternComplete(dots);
                      },
                    ),
                  );
                },
              ),

              const Spacer(),

              // ── Bottom switch to PIN ─────────────────────────────────────
              GestureDetector(
                onTap: () {
                  context.read<SetPatternNavigator>().goToPin();
                },
                child: Text(
                  'Use PIN instead',
                  style: AppTypography.medium.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.black,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
