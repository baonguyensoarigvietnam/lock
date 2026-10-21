import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:applock/application/view_model/global_view_model.dart';
import 'package:applock/application/view_model/global_view_model_state.dart';
import 'package:applock/presentation/theme/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(402, 874),
      minTextAdapt: true,
      splitScreenMode: true,
      autoRebuild: false,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<GlobalViewModel>(
            create: (_) => GetIt.instance<GlobalViewModel>()..init(),
          ),
        ],
        child: BlocBuilder<GlobalViewModel, GlobalViewModelState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'AppLock',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.darkTheme,
              routerConfig: GetIt.instance<GoRouter>(),
            );
          },
        ),
      ),
    );
  }
}
