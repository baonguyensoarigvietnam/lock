import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:applock/presentation/screen/main/main_navigator.dart';
import 'package:applock/presentation/screen/main/view_model/main_view_model.dart';
import 'package:applock/presentation/screen/main/widget/main_view_content.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainViewModel>(
          create: (_) => GetIt.instance<MainViewModel>(),
        ),
        RepositoryProvider<MainNavigator>(
          create: (_) => MainNavigator(router: GoRouter.of(context)),
        ),
      ],
      child: const MainViewContent(),
    );
  }
}
