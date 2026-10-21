import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:applock/presentation/screen/alerts/alerts_navigator.dart';
import 'package:applock/presentation/screen/alerts/view_model/alerts_view_model.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_view_content.dart';

class AlertsPage extends StatelessWidget {
  const AlertsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AlertsViewModel>(
          create: (_) => GetIt.instance<AlertsViewModel>(),
        ),
        RepositoryProvider<AlertsNavigator>(
          create: (_) => AlertsNavigator(router: GoRouter.of(context)),
        ),
      ],
      child: const AlertsViewContent(),
    );
  }
}
