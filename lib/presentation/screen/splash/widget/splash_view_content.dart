import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/domain/model/lock_screen_args.dart';
import 'package:applock/presentation/common/widget/app_lock_shield_badge.dart';
import 'package:applock/presentation/screen/splash/splash_navigator.dart';
import 'package:applock/presentation/screen/splash/view_model/splash_state.dart';
import 'package:applock/presentation/screen/splash/view_model/splash_view_model.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class SplashViewContent extends StatefulWidget {
  const SplashViewContent({super.key});

  @override
  State<SplashViewContent> createState() => _SplashViewContentState();
}

class _SplashViewContentState extends State<SplashViewContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progressController;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SplashViewModel>().checkInitialRoute();
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<SplashViewModel, SplashState>(
      listenWhen: (previous, current) =>
          previous.isSuccess != current.isSuccess && current.isSuccess,
      listener: (context, state) {
        final navigator = context.read<SplashNavigator>();
        switch (state.destination) {
          case SplashDestination.onboarding:
            navigator.goToOnboarding();
          case SplashDestination.setPasscode:
            navigator.goToSetPasscode();
          case SplashDestination.lockScreen:
            navigator.goToLockScreen(
              state.lockArgs ??
                  const LockScreenArgs(mode: LockScreenMode.selfUnlock),
            );
          case null:
            navigator.goToHome();
        }
      },
      child: Scaffold(
        backgroundColor: AppColorsPalette.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppLockShieldBadge(
                size: 88,
                iconSize: 42,
              ),
              const SizedBox(height: 24),
              Text(
                l10n.appLockTitle,
                style: AppTypography.bold.copyWith(
                  fontSize: 26,
                  color: AppColorsPalette.black,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.splashSubtitle,
                style: AppTypography.regular.copyWith(
                  fontSize: 15,
                  color: AppColorsPalette.gray500,
                ),
              ),
              const SizedBox(height: 56),
              // Progress Loading Bar
              _buildProgressBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    const double barWidth = 84.0;
    const double barHeight = 4.0;

    return AnimatedBuilder(
      animation: _progressController,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Container(
            width: barWidth,
            height: barHeight,
            color: AppColorsPalette.gray200,
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: _progressController.value.clamp(0.15, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColorsPalette.black,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
