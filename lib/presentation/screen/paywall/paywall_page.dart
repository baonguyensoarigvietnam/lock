import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:applock/presentation/screen/paywall/paywall_navigator.dart';
import 'package:applock/presentation/screen/paywall/view_model/paywall_view_model.dart';
import 'package:applock/presentation/screen/paywall/widget/paywall_view_content.dart';

class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PaywallViewModel>(
          create: (_) => GetIt.instance<PaywallViewModel>(),
        ),
        RepositoryProvider<PaywallNavigator>(
          create: (_) => PaywallNavigator(router: GoRouter.of(context)),
        ),
      ],
      child: const PaywallViewContent(),
    );
  }
}
