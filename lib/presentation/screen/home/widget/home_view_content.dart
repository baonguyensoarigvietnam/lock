import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/screen/home/view_model/home_state.dart';
import 'package:applock/presentation/screen/home/view_model/home_view_model.dart';
import 'package:applock/presentation/screen/home/widget/home_biometric_card.dart';
import 'package:applock/presentation/screen/home/widget/home_promo_banner.dart';
import 'package:applock/presentation/screen/home/widget/home_quick_actions_section.dart';
import 'package:applock/presentation/screen/home/widget/home_status_cards_section.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class HomeViewContent extends StatefulWidget {
  final ValueChanged<int>? onSelectTab;
  final VoidCallback? onOpenPaywall;

  const HomeViewContent({
    this.onSelectTab,
    this.onOpenPaywall,
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
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  // Top Title
                  Center(
                    child: Text(
                      'App Lock',
                      style: AppTypography.bold.copyWith(
                        fontSize: 20,
                        color: AppColorsPalette.black,
                      ),
                    ),
                  ),
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
                    onToggle: (enabled) {
                      context.read<HomeViewModel>().toggleBiometric(enabled);
                    },
                  ),
                  const SizedBox(height: 24),

                  // Quick Actions Grid
                  HomeQuickActionsSection(
                    onLockAppsTap: () => widget.onSelectTab?.call(1),
                    onVaultTap: () => widget.onSelectTab?.call(2),
                    onThemesTap: () => widget.onOpenPaywall?.call(),
                    onAlertsTap: () => widget.onSelectTab?.call(3),
                  ),
                  const SizedBox(height: 20),

                  // Promotional Banner
                  HomePromoBanner(
                    onTap: () => widget.onOpenPaywall?.call(),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
