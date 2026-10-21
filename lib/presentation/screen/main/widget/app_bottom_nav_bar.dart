import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class AppBottomNavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String Function(BuildContext context) labelBuilder;

  const AppBottomNavItem({
    required this.icon,
    this.activeIcon,
    required this.labelBuilder,
  });
}

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  static final List<AppBottomNavItem> items = [
    AppBottomNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_filled,
      labelBuilder: (context) => context.l10n.navHome,
    ),
    AppBottomNavItem(
      icon: Icons.lock_outline_rounded,
      activeIcon: Icons.lock_rounded,
      labelBuilder: (context) => context.l10n.navApps,
    ),
    AppBottomNavItem(
      icon: Icons.grid_view_outlined,
      activeIcon: Icons.grid_view_rounded,
      labelBuilder: (context) => context.l10n.navVault,
    ),
    AppBottomNavItem(
      icon: Icons.notifications_none_rounded,
      activeIcon: Icons.notifications_rounded,
      labelBuilder: (context) => context.l10n.navAlerts,
    ),
    AppBottomNavItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings_rounded,
      labelBuilder: (context) => context.l10n.navSettings,
    ),
  ];

  const AppBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: AppColorsPalette.white,
        border: Border(
          top: BorderSide(
            color: AppColorsPalette.gray200,
            width: 1.0,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding > 0 ? bottomPadding : 6),
        child: SizedBox(
          height: 60,
          child: Row(
            children: List.generate(items.length, (index) {
              final item = items[index];
              final isSelected = index == currentIndex;

              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  splashColor: AppColorsPalette.transparent,
                  highlightColor: AppColorsPalette.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Top indicator line
                      Container(
                        height: 2.5,
                        width: 44,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColorsPalette.black
                              : AppColorsPalette.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        isSelected ? (item.activeIcon ?? item.icon) : item.icon,
                        size: 22,
                        color: isSelected
                            ? AppColorsPalette.black
                            : AppColorsPalette.gray400,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item.labelBuilder(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? AppColorsPalette.black
                              : AppColorsPalette.gray400,
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
