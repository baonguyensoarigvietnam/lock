import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';

class AppBottomNavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;

  const AppBottomNavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });
}

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  static const List<AppBottomNavItem> items = [
    AppBottomNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_filled,
      label: 'Home',
    ),
    AppBottomNavItem(
      icon: Icons.lock_outline_rounded,
      activeIcon: Icons.lock_rounded,
      label: 'Apps',
    ),
    AppBottomNavItem(
      icon: Icons.grid_view_outlined,
      activeIcon: Icons.grid_view_rounded,
      label: 'Vault',
    ),
    AppBottomNavItem(
      icon: Icons.notifications_none_rounded,
      activeIcon: Icons.notifications_rounded,
      label: 'Alerts',
    ),
    AppBottomNavItem(
      icon: Icons.settings_outlined,
      activeIcon: Icons.settings_rounded,
      label: 'Settings',
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
            color: Color(0xFFE5E7EB),
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
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
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
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        isSelected ? (item.activeIcon ?? item.icon) : item.icon,
                        size: 22,
                        color: isSelected
                            ? AppColorsPalette.black
                            : const Color(0xFF9CA3AF),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? AppColorsPalette.black
                              : const Color(0xFF9CA3AF),
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
