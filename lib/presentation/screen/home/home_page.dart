import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:applock/presentation/screen/home/home_navigator.dart';
import 'package:applock/presentation/screen/home/view_model/home_view_model.dart';
import 'package:applock/presentation/screen/home/widget/home_view_content.dart';

class HomePage extends StatelessWidget {
  final ValueChanged<int>? onSelectTab;

  const HomePage({
    this.onSelectTab,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeViewModel>(
          create: (_) => GetIt.instance<HomeViewModel>(),
        ),
        RepositoryProvider<HomeNavigator>(
          create: (_) => HomeNavigator(router: GoRouter.of(context)),
        ),
      ],
      child: HomeViewContent(onSelectTab: onSelectTab),
    );
  }
}
