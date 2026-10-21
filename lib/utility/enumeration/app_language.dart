import 'package:flutter/material.dart';
import 'package:applock/l10n/app_localizations.dart';

enum AppLanguage {
  en('en', 'English'),
  vi('vi', 'Vietnamese'),
  es('es', 'Spanish'),
  fr('fr', 'French'),
  de('de', 'German'),
  ja('ja', 'Japanese'),
  zh('zh', 'Chinese');

  final String code;
  final String englishName;

  const AppLanguage(this.code, this.englishName);

  Locale get locale => Locale(code);

  String localizedName(AppLocalizations l10n) {
    switch (this) {
      case AppLanguage.en:
        return l10n.langEnglish;
      case AppLanguage.vi:
        return l10n.langVietnamese;
      case AppLanguage.es:
        return l10n.langSpanish;
      case AppLanguage.fr:
        return l10n.langFrench;
      case AppLanguage.de:
        return l10n.langGerman;
      case AppLanguage.ja:
        return l10n.langJapanese;
      case AppLanguage.zh:
        return l10n.langChinese;
    }
  }

  static AppLanguage fromCode(String? code) {
    if (code == null || code.isEmpty) return AppLanguage.en;
    for (final lang in AppLanguage.values) {
      if (lang.code == code) return lang;
    }
    return AppLanguage.en;
  }

  static AppLanguage fromNameOrCode(String value) {
    for (final lang in AppLanguage.values) {
      if (lang.code == value || lang.englishName == value) {
        return lang;
      }
    }
    return AppLanguage.en;
  }
}
