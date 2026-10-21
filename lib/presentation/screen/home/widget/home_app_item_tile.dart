import 'package:flutter/material.dart';
import 'package:applock/domain/model/app_lock_item.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class HomeAppItemTile extends StatelessWidget {
  final AppLockItem item;
  final ValueChanged<bool> onToggle;
  final VoidCallback? onTap;
  final String? customSubtitle;
  final EdgeInsetsGeometry padding;

  const HomeAppItemTile({
    super.key,
    required this.item,
    required this.onToggle,
    this.onTap,
    this.customSubtitle,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
  });

  IconData _resolveIcon(String appName, String packageName) {
    final lower = '${appName.toLowerCase()} ${packageName.toLowerCase()}';
    if (lower.contains('gallery')) return Icons.image_outlined;
    if (lower.contains('message') || lower.contains('messaging')) {
      return Icons.chat_outlined;
    }
    if (lower.contains('photo')) return Icons.photo_library_outlined;
    if (lower.contains('gmail') || lower.contains('email')) {
      return Icons.email_outlined;
    }
    if (lower.contains('instagram') || lower.contains('camera')) {
      return Icons.camera_alt_outlined;
    }
    if (lower.contains('bank')) return Icons.account_balance_outlined;
    if (lower.contains('file') || lower.contains('document')) {
      return Icons.folder_outlined;
    }
    if (lower.contains('setting')) return Icons.settings_outlined;
    if (lower.contains('contact')) return Icons.contact_page_outlined;
    return Icons.apps_rounded;
  }

  @override
  Widget build(BuildContext context) {
    final subtitleText = customSubtitle ?? item.category;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: padding,
        child: Row(
        children: [
          // App Icon Box
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColorsPalette.gray100,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColorsPalette.gray200,
                width: 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: item.icon != null
                  ? Image.memory(item.icon!, fit: BoxFit.cover)
                  : Center(
                      child: Icon(
                        _resolveIcon(item.appName, item.packageName),
                        color: AppColorsPalette.gray600,
                        size: 21,
                      ),
                    ),
            ),
          ),
          const SizedBox(width: 14),
          // App Title & Category/Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.appName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.bold.copyWith(
                    color: AppColorsPalette.black,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitleText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.regular.copyWith(
                    color: AppColorsPalette.gray500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Custom Pill Switch matching design
          GestureDetector(
            onTap: () => onToggle(!item.isLocked),
            behavior: HitTestBehavior.opaque,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeInOut,
              width: 48,
              height: 28,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: item.isLocked
                    ? AppColorsPalette.black
                    : AppColorsPalette.gray200,
                borderRadius: BorderRadius.circular(14),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeInOut,
                alignment: item.isLocked
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    color: item.isLocked
                        ? AppColorsPalette.white
                        : AppColorsPalette.gray100,
                    shape: BoxShape.circle,
                    border: item.isLocked
                        ? null
                        : Border.all(
                            color: AppColorsPalette.gray300,
                            width: 1,
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }
}
