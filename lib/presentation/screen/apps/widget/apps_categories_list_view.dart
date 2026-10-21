import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class AppCategoryItemData {
  final String title;
  final IconData icon;
  final int totalApps;
  final int protectedApps;

  const AppCategoryItemData({
    required this.title,
    required this.icon,
    required this.totalApps,
    required this.protectedApps,
  });
}

class AppsCategoriesListView extends StatelessWidget {
  final ValueChanged<String> onCategoryTap;

  static const List<AppCategoryItemData> categories = [
    AppCategoryItemData(
      title: 'Social',
      icon: Icons.people_outline_rounded,
      totalApps: 12,
      protectedApps: 3,
    ),
    AppCategoryItemData(
      title: 'Messaging',
      icon: Icons.chat_outlined,
      totalApps: 8,
      protectedApps: 2,
    ),
    AppCategoryItemData(
      title: 'Photos & Video',
      icon: Icons.photo_library_outlined,
      totalApps: 15,
      protectedApps: 0,
    ),
    AppCategoryItemData(
      title: 'Finance',
      icon: Icons.account_balance_wallet_outlined,
      totalApps: 6,
      protectedApps: 6,
    ),
    AppCategoryItemData(
      title: 'Shopping',
      icon: Icons.shopping_bag_outlined,
      totalApps: 9,
      protectedApps: 0,
    ),
    AppCategoryItemData(
      title: 'System',
      icon: Icons.settings_applications_outlined,
      totalApps: 42,
      protectedApps: 1,
    ),
  ];

  const AppsCategoriesListView({
    required this.onCategoryTap,
    super.key,
  });

  static String resolveCategoryTitle(BuildContext context, String key) {
    final l10n = context.l10n;
    switch (key) {
      case 'Social':
        return l10n.categorySocial;
      case 'Messaging':
        return l10n.categoryMessaging;
      case 'Photos & Video':
        return l10n.categoryPhotosVideo;
      case 'Finance':
        return l10n.categoryFinance;
      case 'Shopping':
        return l10n.categoryShopping;
      case 'System':
      case 'System App':
        return l10n.categorySystem;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 6, bottom: 20),
      itemCount: categories.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final category = categories[index];
        final hasProtected = category.protectedApps > 0;
        final localizedTitle = resolveCategoryTitle(context, category.title);

        return InkWell(
          onTap: () => onCategoryTap(category.title),
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
                      category.icon,
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
