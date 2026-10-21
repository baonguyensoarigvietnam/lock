import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:applock/presentation/screen/set_pattern/set_pattern_navigator.dart';
import 'package:applock/presentation/screen/set_pattern/view_model/set_pattern_view_model.dart';
import 'package:applock/presentation/screen/set_pattern/widget/set_pattern_view_content.dart';

class SetPatternPage extends StatelessWidget {
  const SetPatternPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SetPatternViewModel>(
          create: (_) => GetIt.instance<SetPatternViewModel>(),
        ),
        RepositoryProvider<SetPatternNavigator>(
          create: (_) => SetPatternNavigator(router: GoRouter.of(context)),
        ),
      ],
      child: const SetPatternViewContent(),
    );
  }
}
