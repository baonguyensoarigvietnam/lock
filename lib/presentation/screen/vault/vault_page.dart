import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:applock/presentation/screen/vault/vault_navigator.dart';
import 'package:applock/presentation/screen/vault/view_model/vault_view_model.dart';
import 'package:applock/presentation/screen/vault/widget/vault_view_content.dart';

class VaultPage extends StatelessWidget {
  const VaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VaultViewModel>(
          create: (_) => GetIt.instance<VaultViewModel>()..loadItems(),
        ),
        RepositoryProvider<VaultNavigator>(
          create: (_) => VaultNavigator(router: GoRouter.of(context)),
        ),
      ],
      child: const VaultViewContent(),
    );
  }
}
