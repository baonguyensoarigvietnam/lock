import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:applock/presentation/screen/apps/apps_navigator.dart';
import 'package:applock/presentation/screen/apps/view_model/apps_view_model.dart';
import 'package:applock/presentation/screen/apps/widget/apps_view_content.dart';

class AppsPage extends StatelessWidget {
  const AppsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppsViewModel>(
          create: (_) => GetIt.instance<AppsViewModel>(),
        ),
        RepositoryProvider<AppsNavigator>(
          create: (_) => AppsNavigator(router: GoRouter.of(context)),
        ),
      ],
      child: const AppsViewContent(),
    );
  }
}
