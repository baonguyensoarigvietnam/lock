import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:applock/presentation/screen/enable_biometric/enable_biometric_navigator.dart';
import 'package:applock/presentation/screen/enable_biometric/view_model/enable_biometric_view_model.dart';
import 'package:applock/presentation/screen/enable_biometric/widget/enable_biometric_view_content.dart';

class EnableBiometricPage extends StatelessWidget {
  const EnableBiometricPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<EnableBiometricViewModel>(
          create: (_) => GetIt.instance<EnableBiometricViewModel>(),
        ),
        RepositoryProvider<EnableBiometricNavigator>(
          create: (_) =>
              EnableBiometricNavigator(router: GoRouter.of(context)),
        ),
      ],
      child: const EnableBiometricViewContent(),
    );
  }
}
