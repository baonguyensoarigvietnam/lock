import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/screen/alerts/alerts_page.dart';
import 'package:applock/presentation/screen/apps/apps_page.dart';
import 'package:applock/presentation/screen/home/home_page.dart';
import 'package:applock/presentation/screen/main/view_model/main_state.dart';
import 'package:applock/presentation/screen/main/view_model/main_view_model.dart';
import 'package:applock/presentation/screen/main/widget/app_bottom_nav_bar.dart';
import 'package:applock/presentation/screen/settings/settings_page.dart';
import 'package:applock/presentation/screen/vault/vault_page.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';

class MainViewContent extends StatelessWidget {
  const MainViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainViewModel, MainState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColorsPalette.white,
          body: IndexedStack(
            index: state.currentTabIndex,
            children: [
              HomePage(
                onSelectTab: (index) {
                  context.read<MainViewModel>().setTab(index);
                },
              ),
              const AppsPage(),
              const VaultPage(),
              const AlertsPage(),
              const SettingsPage(),
            ],
          ),
          bottomNavigationBar: AppBottomNavBar(
            currentIndex: state.currentTabIndex,
            onTap: (index) {
              context.read<MainViewModel>().setTab(index);
            },
          ),
        );
      },
    );
  }
}
