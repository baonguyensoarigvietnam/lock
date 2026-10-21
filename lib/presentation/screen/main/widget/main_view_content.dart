import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/screen/home/widget/home_view_content.dart';
import 'package:applock/presentation/screen/main/main_navigator.dart';
import 'package:applock/presentation/screen/main/view_model/main_state.dart';
import 'package:applock/presentation/screen/main/view_model/main_view_model.dart';
import 'package:applock/presentation/screen/main/widget/alerts_tab_content.dart';
import 'package:applock/presentation/screen/main/widget/app_bottom_nav_bar.dart';
import 'package:applock/presentation/screen/main/widget/apps_tab_content.dart';
import 'package:applock/presentation/screen/main/widget/settings_tab_content.dart';
import 'package:applock/presentation/screen/main/widget/vault_tab_content.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';

class MainViewContent extends StatelessWidget {
  const MainViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainViewModel, MainState>(
      builder: (context, state) {
        final navigator = context.read<MainNavigator>();

        return Scaffold(
          backgroundColor: AppColorsPalette.white,
          body: IndexedStack(
            index: state.currentTabIndex,
            children: [
              HomeViewContent(
                onSelectTab: (index) {
                  context.read<MainViewModel>().setTab(index);
                },
                onOpenPaywall: () => navigator.goToPaywall(),
              ),
              const AppsTabContent(),
              const VaultTabContent(),
              const AlertsTabContent(),
              SettingsTabContent(
                onGoToSetPasscode: () => navigator.goToSetPasscode(),
                onGoToSetPattern: () => navigator.goToSetPattern(),
                onGoToLockScreen: () => navigator.goToLockScreen(),
                onGoToPermissionGuide: () => navigator.goToPermissionGuide(),
                onGoToPaywall: () => navigator.goToPaywall(),
              ),
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
