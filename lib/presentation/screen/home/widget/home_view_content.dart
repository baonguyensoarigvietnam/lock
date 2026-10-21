import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/screen/home/home_navigator.dart';
import 'package:applock/presentation/screen/home/view_model/home_state.dart';
import 'package:applock/presentation/screen/home/view_model/home_view_model.dart';
import 'package:applock/presentation/screen/home/widget/home_biometric_card.dart';
import 'package:applock/presentation/screen/home/widget/home_premium_color_preview_view.dart';
import 'package:applock/presentation/screen/home/widget/home_promo_banner.dart';
import 'package:applock/presentation/screen/home/widget/home_quick_actions_section.dart';
import 'package:applock/presentation/screen/home/widget/home_status_cards_section.dart';
import 'package:applock/presentation/screen/home/widget/home_theme_applied_view.dart';
import 'package:applock/presentation/screen/home/widget/home_theme_picker_view.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/utility/enumeration/home_theme_step.dart';

class HomeViewContent extends StatefulWidget {
  final ValueChanged<int>? onSelectTab;

  const HomeViewContent({
    this.onSelectTab,
    super.key,
  });

  @override
  State<HomeViewContent> createState() => _HomeViewContentState();
}

class _HomeViewContentState extends State<HomeViewContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPalette.white,
      body: SafeArea(
        child: BlocBuilder<HomeViewModel, HomeState>(
          builder: (context, state) {
            return _buildStepContent(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildStepContent(BuildContext context, HomeState state) {
    final vm = context.read<HomeViewModel>();
    final navigator = context.read<HomeNavigator>();

    switch (state.currentStep) {
      case HomeThemeStep.dashboard:
        return _buildDashboardContent(context, state, vm, navigator);
      case HomeThemeStep.themePicker:
        return HomeThemePickerView(
          onApplyTheme: () => vm.setThemeStep(HomeThemeStep.themeApplied),
          onOpenPremiumPreview: () =>
              vm.setThemeStep(HomeThemeStep.premiumColorPreview),
          onBackToDashboard: () => vm.setThemeStep(HomeThemeStep.dashboard),
        );
      case HomeThemeStep.themeApplied:
        return HomeThemeAppliedView(
          onDone: () => vm.setThemeStep(HomeThemeStep.dashboard),
        );
      case HomeThemeStep.premiumColorPreview:
        return HomePremiumColorPreviewView(
          onUpgradeToPremium: () => navigator.goToPaywall(),
          onBackToThemes: () => vm.setThemeStep(HomeThemeStep.themePicker),
        );
    }
  }

  Widget _buildDashboardContent(
    BuildContext context,
    HomeState state,
    HomeViewModel vm,
    HomeNavigator navigator,
  ) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const CommonAppBar.brand(),
          const SizedBox(height: 20),

          // Status Overview Cards
          HomeStatusCardsSection(
            lockedCount: state.lockedCount,
            isServiceActive: state.isServiceActive,
            vaultItemsCount: 72,
            intruderAlertsCount: 2,
            onAppsProtectedTap: () => widget.onSelectTab?.call(1),
            onVaultTap: () => widget.onSelectTab?.call(2),
            onAlertsTap: () => widget.onSelectTab?.call(3),
          ),
          const SizedBox(height: 16),

          // Biometric Fallback Toggle
          HomeBiometricCard(
            isEnabled: state.isBiometricEnabled,
            onToggle: (enabled) => vm.toggleBiometric(enabled),
          ),
          const SizedBox(height: 24),

          // Quick Actions Grid
          HomeQuickActionsSection(
            onLockAppsTap: () => widget.onSelectTab?.call(1),
            onVaultTap: () => widget.onSelectTab?.call(2),
            onThemesTap: () => vm.setThemeStep(HomeThemeStep.themePicker),
            onAlertsTap: () => widget.onSelectTab?.call(3),
          ),
          const SizedBox(height: 20),

          // Promotional Banner
          HomePromoBanner(
            onTap: () => navigator.goToPaywall(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
