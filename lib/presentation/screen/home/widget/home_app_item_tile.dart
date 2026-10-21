import 'package:flutter/material.dart';
import 'package:applock/domain/model/app_lock_item.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class HomeAppItemTile extends StatelessWidget {
  final AppLockItem item;
  final ValueChanged<bool> onToggle;

  const HomeAppItemTile({
    super.key,
    required this.item,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColorsPalette.slate800,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.isLocked
              ? AppColorsPalette.primary.withValues(alpha: 0.5)
              : AppColorsPalette.gray800,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // App Icon
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 44,
              height: 44,
              child: item.icon != null
                  ? Image.memory(item.icon!, fit: BoxFit.cover)
                  : Container(
                      color: AppColorsPalette.primary.withValues(alpha: 0.15),
                      child: const Icon(
                        Icons.apps_rounded,
                        color: AppColorsPalette.primary,
                        size: 24,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 14),
          // App Title & Package
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.appName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.semiBold.copyWith(
                    color: AppColorsPalette.white,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.packageName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.regular.copyWith(
                    color: AppColorsPalette.gray400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Lock / Unlock Switch
          Switch(
            value: item.isLocked,
            activeThumbColor: AppColorsPalette.primary,
            activeTrackColor: AppColorsPalette.primary.withValues(alpha: 0.4),
            inactiveThumbColor: AppColorsPalette.gray400,
            inactiveTrackColor: AppColorsPalette.slate900,
            onChanged: onToggle,
          ),
        ],
      ),
    );
  }
}
