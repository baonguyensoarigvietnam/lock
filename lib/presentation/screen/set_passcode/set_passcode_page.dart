import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:applock/presentation/screen/set_passcode/set_passcode_navigator.dart';
import 'package:applock/presentation/screen/set_passcode/view_model/set_passcode_view_model.dart';
import 'package:applock/presentation/screen/set_passcode/widget/set_passcode_view_content.dart';

class SetPasscodePage extends StatelessWidget {
  const SetPasscodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SetPasscodeViewModel>(
          create: (_) => GetIt.instance<SetPasscodeViewModel>(),
        ),
        RepositoryProvider<SetPasscodeNavigator>(
          create: (_) => SetPasscodeNavigator(router: GoRouter.of(context)),
        ),
      ],
      child: const SetPasscodeViewContent(),
    );
  }
}
