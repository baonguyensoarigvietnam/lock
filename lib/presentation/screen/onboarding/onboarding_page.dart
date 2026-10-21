import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:applock/presentation/screen/onboarding/onboarding_navigator.dart';
import 'package:applock/presentation/screen/onboarding/view_model/onboarding_view_model.dart';
import 'package:applock/presentation/screen/onboarding/widget/onboarding_view_content.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnboardingViewModel>(
          create: (_) => GetIt.instance<OnboardingViewModel>(),
        ),
        RepositoryProvider<OnboardingNavigator>(
          create: (_) => OnboardingNavigator(router: GoRouter.of(context)),
        ),
      ],
      child: const OnboardingViewContent(),
    );
  }
}
