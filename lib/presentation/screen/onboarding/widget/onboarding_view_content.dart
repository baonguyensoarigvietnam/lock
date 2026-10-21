import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/screen/onboarding/onboarding_navigator.dart';
import 'package:applock/presentation/screen/onboarding/view_model/onboarding_state.dart';
import 'package:applock/presentation/screen/onboarding/view_model/onboarding_view_model.dart';
import 'package:applock/presentation/screen/onboarding/widget/onboarding_step_one_view.dart';
import 'package:applock/presentation/screen/onboarding/widget/onboarding_step_two_view.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';

class OnboardingViewContent extends StatefulWidget {
  const OnboardingViewContent({super.key});

  @override
  State<OnboardingViewContent> createState() => _OnboardingViewContentState();
}

class _OnboardingViewContentState extends State<OnboardingViewContent> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingViewModel, OnboardingState>(
      listenWhen: (previous, current) =>
          !previous.isCompleted && current.isCompleted,
      listener: (context, state) {
        context.read<OnboardingNavigator>().goToUnlockMethod();
      },
      child: Scaffold(
        backgroundColor: AppColorsPalette.white,
        body: PageView(
          controller: _pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (page) {
            context.read<OnboardingViewModel>().setPage(page);
          },
          children: [
            OnboardingStepOneView(
              onContinue: () {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                );
              },
            ),
            OnboardingStepTwoView(
              onGetStarted: () {
                context.read<OnboardingViewModel>().completeOnboarding();
              },
            ),
          ],
        ),
      ),
    );
  }
}
