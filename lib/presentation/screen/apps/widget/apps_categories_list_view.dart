import 'package:flutter/material.dart';
import 'package:applock/domain/model/app_lock_item.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/enumeration/app_category.dart';
import 'package:applock/utility/extension/build_context.dart';

class AppCategoryItemData {
  final AppCategory category;
  final int totalApps;
  final int protectedApps;

  const AppCategoryItemData({
    required this.category,
    required this.totalApps,
    required this.protectedApps,
  });
}

class AppsCategoriesListView extends StatelessWidget {
  final List<AppLockItem> apps;
  final ValueChanged<AppCategory> onCategoryTap;

  const AppsCategoriesListView({
    required this.apps,
    required this.onCategoryTap,
    super.key,
  });

  List<AppCategoryItemData> _buildCategories() {
    final result = <AppCategoryItemData>[];
    for (final category in AppCategory.values) {
      final inCategory = apps.where((a) => a.category == category);
      final total = inCategory.length;
      if (total == 0) continue;
      result.add(AppCategoryItemData(
        category: category,
        totalApps: total,
        protectedApps: inCategory.where((a) => a.isLocked).length,
      ));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final categories = _buildCategories();
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 6, bottom: 20),
      itemCount: categories.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final category = categories[index];
        final hasProtected = category.protectedApps > 0;
        final localizedTitle = category.category.label(l10n);

        return InkWell(
          onTap: () => onCategoryTap(category.category),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: AppColorsPalette.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColorsPalette.gray200,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColorsPalette.gray100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(
                      category.category.icon,
                      color: AppColorsPalette.black,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizedTitle,
                        style: AppTypography.bold.copyWith(
                          fontSize: 15,
                          color: AppColorsPalette.black,
                        ),
                      ),
                      const SizedBox(height: 3),
                      RichText(
                        text: TextSpan(
                          style: AppTypography.regular.copyWith(
                            fontSize: 12,
                            color: AppColorsPalette.gray500,
                          ),
                          children: [
                            TextSpan(
                              text: l10n.categoryAppsBullet(category.totalApps),
                            ),
                            TextSpan(
                              text: l10n.categoryProtectedCount(
                                category.protectedApps,
                              ),
                              style: AppTypography.medium.copyWith(
                                fontSize: 12,
                                color: hasProtected
                                    ? AppColorsPalette.gray800
                                    : AppColorsPalette.gray500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColorsPalette.gray500,
                  size: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
