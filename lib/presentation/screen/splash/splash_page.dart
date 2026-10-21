import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:applock/presentation/screen/splash/splash_navigator.dart';
import 'package:applock/presentation/screen/splash/view_model/splash_view_model.dart';
import 'package:applock/presentation/screen/splash/widget/splash_view_content.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashViewModel>(
          create: (_) => GetIt.instance<SplashViewModel>(),
        ),
        RepositoryProvider<SplashNavigator>(
          create: (_) => SplashNavigator(router: GoRouter.of(context)),
        ),
      ],
      child: const SplashViewContent(),
    );
  }
}
