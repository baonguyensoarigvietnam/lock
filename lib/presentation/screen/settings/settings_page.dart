import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:applock/presentation/screen/settings/settings_navigator.dart';
import 'package:applock/presentation/screen/settings/view_model/settings_view_model.dart';
import 'package:applock/presentation/screen/settings/widget/settings_view_content.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsViewModel>(
          create: (_) => GetIt.instance<SettingsViewModel>(),
        ),
        RepositoryProvider<SettingsNavigator>(
          create: (_) => SettingsNavigator(router: GoRouter.of(context)),
        ),
      ],
      child: const SettingsViewContent(),
    );
  }
}
