import 'package:applock/presentation/common/widget/banner_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/screen/apps/view_model/apps_state.dart';
import 'package:applock/presentation/screen/apps/view_model/apps_view_model.dart';
import 'package:applock/presentation/screen/apps/widget/apps_categories_list_view.dart';
import 'package:applock/presentation/screen/apps/widget/apps_item_tile.dart';
import 'package:applock/presentation/screen/apps/widget/apps_limited_protection_view.dart';
import 'package:applock/presentation/screen/apps/widget/apps_usage_access_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/enumeration/apps_filter_tab.dart';
import 'package:applock/utility/enumeration/apps_tab_step.dart';
import 'package:applock/utility/extension/build_context.dart';

class AppsViewContent extends StatefulWidget {
  const AppsViewContent({super.key});

  @override
  State<AppsViewContent> createState() => _AppsViewContentState();
}

class _AppsViewContentState extends State<AppsViewContent> {
  final TextEditingController _searchController = TextEditingController();
  late final AppLifecycleListener _lifecycleListener;

  @override
  void initState() {
    super.initState();
    // Coming back from a system settings page: re-check permissions.
    _lifecycleListener = AppLifecycleListener(
      onResume: () => context.read<AppsViewModel>().refreshPermissions(),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppsViewModel>().init();
    });
  }

  @override
  void dispose() {
    _lifecycleListener.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPalette.white,
      body: SafeArea(
        child: BlocBuilder<AppsViewModel, AppsState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(height: 12),
                const CommonAppBar.brand(),
                const SizedBox(height: 12),
                Expanded(child: _buildStepBody(context, state)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStepBody(BuildContext context, AppsState state) {
    final vm = context.read<AppsViewModel>();

    switch (state.appsTabStep) {
      case AppsTabStep.usageAccessRequired:
        return AppsUsageAccessCard(
          onEnableTap: () => vm.enableUsageAccessFromAppsTab(),
        );
      case AppsTabStep.limitedProtectionWarning:
        return AppsLimitedProtectionView(
          isOverlayGranted: state.isOverlayGranted,
          isBatteryOptimizationIgnored: state.isBatteryOptimizationIgnored,
          onFixPermissions: () => vm.fixLimitedPermissions(),
          onContinueLimited: () => vm.continueWithLimitedProtection(),
        );
      case AppsTabStep.appList:
        return _buildLockedAppsMainContent(context, state);
    }
  }

  Widget _buildLockedAppsMainContent(BuildContext context, AppsState state) {
    final vm = context.read<AppsViewModel>();
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 6),
          const BannerAdWidget(adSize: .banner),
          const SizedBox(height: 10),
          // Header Row: "Locked Apps" + "5 protected apps" badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.lockedAppsHeader,
                style: AppTypography.bold.copyWith(
                  fontSize: 22,
                  color: AppColorsPalette.black,
                ),
              ),
              GestureDetector(
                onTap: () => vm.setAppsFilterTab(AppsFilterTab.locked),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColorsPalette.gray100,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColorsPalette.gray200,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    l10n.protectedAppsCount(state.lockedCount),
                    style: AppTypography.medium.copyWith(
                      fontSize: 12,
                      color: AppColorsPalette.gray500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Search Bar
          Container(
            height: 44,
            decoration: BoxDecoration(
              color: AppColorsPalette.gray50,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColorsPalette.gray200, width: 1),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (val) => vm.search(val),
              style: AppTypography.regular.copyWith(
                fontSize: 14,
                color: AppColorsPalette.black,
              ),
              decoration: InputDecoration(
                hintText: l10n.searchAppsHint,
                hintStyle: AppTypography.regular.copyWith(
                  color: AppColorsPalette.gray400,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColorsPalette.gray500,
                  size: 20,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 11),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Segmented Tab Bar: All | Categories | Locked
          Container(
            height: 44,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColorsPalette.gray100,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColorsPalette.gray200, width: 1),
            ),
            child: Row(
              children: [
                _buildSegmentTab(
                  context: context,
                  label: l10n.filterAll,
                  tab: AppsFilterTab.all,
                  currentTab: state.appsFilterTab,
                ),
                _buildSegmentTab(
                  context: context,
                  label: l10n.filterCategories,
                  tab: AppsFilterTab.categories,
                  currentTab: state.appsFilterTab,
                ),
                _buildSegmentTab(
                  context: context,
                  label: l10n.filterLocked,
                  tab: AppsFilterTab.locked,
                  currentTab: state.appsFilterTab,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Active Category Filter Chip (if filtered from Categories tab)
          if (state.selectedCategory != null &&
              state.appsFilterTab == AppsFilterTab.all)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColorsPalette.gray100,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColorsPalette.gray200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          l10n.categoryChipLabel(
                            state.selectedCategory!.label(l10n),
                          ),
                          style: AppTypography.medium.copyWith(
                            fontSize: 12,
                            color: AppColorsPalette.gray700,
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () => vm.selectCategory(null),
                          child: const Icon(
                            Icons.close_rounded,
                            size: 14,
                            color: AppColorsPalette.gray600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Tab Content Area
          Expanded(child: _buildTabViewContent(context, state)),
        ],
      ),
    );
  }

  Widget _buildSegmentTab({
    required BuildContext context,
    required String label,
    required AppsFilterTab tab,
    required AppsFilterTab currentTab,
  }) {
    final isSelected = tab == currentTab;
    return Expanded(
      child: GestureDetector(
        onTap: () => context.read<AppsViewModel>().setAppsFilterTab(tab),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 160),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColorsPalette.black
                : AppColorsPalette.transparent,
            borderRadius: BorderRadius.circular(7),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: AppTypography.semiBold.copyWith(
              fontSize: 13,
              color: isSelected
                  ? AppColorsPalette.white
                  : AppColorsPalette.gray500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabViewContent(BuildContext context, AppsState state) {
    final vm = context.read<AppsViewModel>();
    final l10n = context.l10n;

    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColorsPalette.black),
      );
    }

    switch (state.appsFilterTab) {
      case AppsFilterTab.categories:
        return AppsCategoriesListView(
          apps: state.apps,
          onCategoryTap: (category) => vm.selectCategory(category),
        );
      case AppsFilterTab.locked:
        final lockedApps = state.filteredApps;
        if (lockedApps.isEmpty) {
          return Center(
            child: Text(
              l10n.noLockedAppsFound,
              style: AppTypography.regular.copyWith(
                color: AppColorsPalette.gray500,
                fontSize: 14,
              ),
            ),
          );
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 4, bottom: 20),
          child: Container(
            decoration: BoxDecoration(
              color: AppColorsPalette.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColorsPalette.gray200, width: 1),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: lockedApps.length,
              separatorBuilder: (_, _) => const Divider(
                height: 1,
                thickness: 1,
                color: AppColorsPalette.gray100,
              ),
              itemBuilder: (context, index) {
                final item = lockedApps[index];
                return AppsItemTile(
                  item: item,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  onTap: () => vm.toggleLock(item.packageName),
                  onToggle: (_) => vm.toggleLock(item.packageName),
                );
              },
            ),
          ),
        );
      case AppsFilterTab.all:
        if (state.filteredApps.isEmpty) {
          return Center(
            child: Text(
              l10n.noAppsFound,
              style: AppTypography.regular.copyWith(
                color: AppColorsPalette.gray500,
                fontSize: 14,
              ),
            ),
          );
        }
        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 4, bottom: 20),
          itemCount: state.filteredApps.length,
          separatorBuilder: (_, _) => const Divider(
            height: 1,
            thickness: 1,
            color: AppColorsPalette.gray100,
          ),
          itemBuilder: (context, index) {
            final item = state.filteredApps[index];
            return AppsItemTile(
              item: item,
              onTap: () => vm.toggleLock(item.packageName),
              onToggle: (_) => vm.toggleLock(item.packageName),
            );
          },
        );
    }
  }
}
