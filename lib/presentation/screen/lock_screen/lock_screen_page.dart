import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:applock/domain/model/lock_screen_args.dart';
import 'package:applock/presentation/screen/lock_screen/lock_screen_navigator.dart';
import 'package:applock/presentation/screen/lock_screen/view_model/lock_screen_view_model.dart';
import 'package:applock/presentation/screen/lock_screen/widget/lock_screen_view_content.dart';

class LockScreenPage extends StatelessWidget {
  final LockScreenArgs args;

  const LockScreenPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LockScreenViewModel>(
          create: (_) => GetIt.instance<LockScreenViewModel>(),
        ),
        RepositoryProvider<LockScreenNavigator>(
          create: (_) => LockScreenNavigator(router: GoRouter.of(context)),
        ),
      ],
      child: LockScreenViewContent(args: args),
    );
  }
}
