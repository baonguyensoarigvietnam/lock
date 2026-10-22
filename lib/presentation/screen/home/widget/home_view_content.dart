import 'package:applock/presentation/common/widget/banner_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:applock/application/view_model/global_view_model.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/common/widget/native_ad_widget.dart';
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
import 'package:applock/presentation/screen/main/view_model/main_state.dart';
import 'package:applock/presentation/screen/main/view_model/main_view_model.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/utility/enumeration/biometric_toggle_result.dart';
import 'package:applock/utility/enumeration/home_theme_step.dart';
import 'package:applock/utility/extension/build_context.dart';
import 'package:applock/utility/snack_bar_utility.dart';

class HomeViewContent extends StatefulWidget {
  final ValueChanged<int>? onSelectTab;

  const HomeViewContent({this.onSelectTab, super.key});

  @override
  State<HomeViewContent> createState() => _HomeViewContentState();
}

class _HomeViewContentState extends State<HomeViewContent> {
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    _lifecycleListener = AppLifecycleListener(
      onResume: () => context.read<HomeViewModel>().init(),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().init();
    });
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    super.dispose();
  }

  Future<void> _onToggleBiometric(bool enabled) async {
    final l10n = context.l10n;
    final result = await context.read<HomeViewModel>().toggleBiometric(
      enabled,
      localizedReason: l10n.lockEnableBiometricReason,
    );
    if (!mounted) return;
    if (result == BiometricToggleResult.notSupported) {
      SnackBarUtility.show(context, l10n.biometricNotSupportedError);
    }
  }

  @override
  Widget build(BuildContext context) {
    final body = Scaffold(
      backgroundColor: AppColorsPalette.white,
      body: SafeArea(
        child: BlocBuilder<HomeViewModel, HomeState>(
          builder: (context, state) {
            return _buildStepContent(context, state);
          },
        ),
      ),
    );

    // Refresh counters whenever the user comes back to the Home tab
    // (Home always lives inside MainPage which provides MainViewModel).
    return BlocListener<MainViewModel, MainState>(
      listenWhen: (prev, curr) =>
          prev.currentTabIndex != curr.currentTabIndex &&
          curr.currentTabIndex == 0,
      listener: (context, _) => context.read<HomeViewModel>().init(),
      child: body,
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
          currentTheme: state.lockScreenTheme,
          onApplyTheme: vm.applyLockScreenTheme,
          onOpenPremiumPreview: () =>
              vm.setThemeStep(HomeThemeStep.premiumColorPreview),
          onBackToDashboard: () => vm.setThemeStep(HomeThemeStep.dashboard),
        );
      case HomeThemeStep.themeApplied:
        return HomeThemeAppliedView(
          onDone: () {
            context.read<GlobalViewModel>().showInterstitialAd(
              onDismiss: () => vm.setThemeStep(HomeThemeStep.dashboard),
            );
          },
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
          const BannerAdWidget(
            useAdaptiveSize: true,
            padding: EdgeInsets.only(bottom: 16),
          ),
          // Status Overview Cards
          HomeStatusCardsSection(
            lockedCount: state.lockedCount,
            isServiceActive: state.isServiceActive,
            vaultItemsCount: state.vaultItemsCount,
            intruderAlertsCount: state.intruderAlertsCount,
            onAppsProtectedTap: () => widget.onSelectTab?.call(1),
            onVaultTap: () => widget.onSelectTab?.call(2),
            onAlertsTap: () => widget.onSelectTab?.call(3),
          ),
          const SizedBox(height: 16),

          // Biometric Fallback Toggle
          HomeBiometricCard(
            isEnabled: state.isBiometricEnabled,
            onToggle: _onToggleBiometric,
          ),
          const SizedBox(height: 24),

          // Quick Actions Grid
          HomeQuickActionsSection(
            onLockAppsTap: () => widget.onSelectTab?.call(1),
            onVaultTap: () => widget.onSelectTab?.call(2),
            onThemesTap: () => vm.setThemeStep(HomeThemeStep.themePicker),
            onAlertsTap: () => widget.onSelectTab?.call(3),
          ),
          if (!context.select<GlobalViewModel, bool>(
            (vm) => vm.state.isPremium,
          )) ...[
            const SizedBox(height: 20),
            // Promotional Banner
            HomePromoBanner(onTap: () => navigator.goToPaywall()),
            const NativeAdWidget(
              templateType: TemplateType.small,
              padding: EdgeInsets.only(top: 16),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
