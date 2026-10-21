import 'package:flutter/material.dart';
import 'package:applock/l10n/app_localizations.dart';

/// Coarse category inferred from an app's package name / label.
enum AppCategory {
  social(Icons.people_outline_rounded),
  messaging(Icons.chat_outlined),
  media(Icons.photo_library_outlined),
  finance(Icons.account_balance_wallet_outlined),
  shopping(Icons.shopping_bag_outlined),
  system(Icons.settings_applications_outlined),
  other(Icons.apps_rounded);

  const AppCategory(this.icon);

  final IconData icon;

  String label(AppLocalizations l10n) {
    switch (this) {
      case AppCategory.social:
        return l10n.categorySocial;
      case AppCategory.messaging:
        return l10n.categoryMessaging;
      case AppCategory.media:
        return l10n.categoryPhotosVideo;
      case AppCategory.finance:
        return l10n.categoryFinance;
      case AppCategory.shopping:
        return l10n.categoryShopping;
      case AppCategory.system:
        return l10n.categorySystem;
      case AppCategory.other:
        return l10n.appsCategoryOther;
    }
  }

  static AppCategory infer({
    required String packageName,
    required String appName,
    required bool isSystem,
  }) {
    final text = '${packageName.toLowerCase()} ${appName.toLowerCase()}';
    bool has(List<String> keys) => keys.any(text.contains);

    if (has(['instagram', 'facebook', 'katana', 'tiktok', 'musically',
        'twitter', 'threads', 'snapchat', 'reddit', 'pinterest', 'linkedin',
        'social'])) {
      return AppCategory.social;
    }
    if (has(['messag', 'mms', 'sms', 'mail', 'zalo', 'orca', 'whatsapp',
        'telegram', 'viber', 'naver.line', 'signal', 'skype', 'discord', 'chat',
        'dialer', 'contacts'])) {
      return AppCategory.messaging;
    }
    if (has(['photo', 'gallery', 'camera', 'video', 'youtube', 'music',
        'spotify', 'netflix', 'player'])) {
      return AppCategory.media;
    }
    if (has(['bank', 'wallet', 'pay', 'finance', 'momo', 'vnpay', 'crypto',
        'binance'])) {
      return AppCategory.finance;
    }
    if (has(['shop', 'store', 'amazon', 'shopee', 'lazada', 'tiki', 'ebay',
        'aliexpress'])) {
      return AppCategory.shopping;
    }
    return isSystem ? AppCategory.system : AppCategory.other;
  }
}
