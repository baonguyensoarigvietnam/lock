import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:applock/presentation/screen/permission_guide/permission_guide_navigator.dart';
import 'package:applock/presentation/screen/permission_guide/view_model/permission_guide_view_model.dart';
import 'package:applock/presentation/screen/permission_guide/widget/permission_guide_view_content.dart';

class PermissionGuidePage extends StatelessWidget {
  const PermissionGuidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PermissionGuideViewModel>(
          create: (_) => GetIt.instance<PermissionGuideViewModel>(),
        ),
        RepositoryProvider<PermissionGuideNavigator>(
          create: (_) => PermissionGuideNavigator(router: GoRouter.of(context)),
        ),
      ],
      child: const PermissionGuideViewContent(),
    );
  }
}
