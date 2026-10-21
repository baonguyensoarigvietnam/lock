import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:applock/presentation/screen/unlock_method/unlock_method_navigator.dart';
import 'package:applock/presentation/screen/unlock_method/view_model/unlock_method_view_model.dart';
import 'package:applock/presentation/screen/unlock_method/widget/unlock_method_view_content.dart';

class UnlockMethodPage extends StatelessWidget {
  const UnlockMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UnlockMethodViewModel>(
          create: (_) => GetIt.instance<UnlockMethodViewModel>(),
        ),
        RepositoryProvider<UnlockMethodNavigator>(
          create: (_) => UnlockMethodNavigator(router: GoRouter.of(context)),
        ),
      ],
      child: const UnlockMethodViewContent(),
    );
  }
}
