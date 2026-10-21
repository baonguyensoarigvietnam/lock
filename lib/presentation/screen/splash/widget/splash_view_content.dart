import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/common/widget/app_lock_shield_badge.dart';
import 'package:applock/presentation/screen/splash/splash_navigator.dart';
import 'package:applock/presentation/screen/splash/view_model/splash_state.dart';
import 'package:applock/presentation/screen/splash/view_model/splash_view_model.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

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
    return BlocListener<SplashViewModel, SplashState>(
      listenWhen: (previous, current) =>
          previous.isSuccess != current.isSuccess && current.isSuccess,
      listener: (context, state) {
        final navigator = context.read<SplashNavigator>();
        if (!state.isOnboardingCompleted) {
          navigator.goToOnboarding();
        } else if (state.hasPin) {
          navigator.goToHome();
        } else {
          navigator.goToSetPasscode();
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
                'App Lock',
                style: AppTypography.bold.copyWith(
                  fontSize: 26,
                  color: AppColorsPalette.black,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Protect your private content',
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
