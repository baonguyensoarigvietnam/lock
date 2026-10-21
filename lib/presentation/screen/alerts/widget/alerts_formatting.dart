import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:applock/domain/model/intruder_alert.dart';
import 'package:applock/l10n/app_localizations.dart';
import 'package:applock/utility/enumeration/intruder_unlock_method.dart';
import 'package:applock/utility/extension/build_context.dart';

/// Localized presentation helpers for [IntruderAlert].
extension IntruderAlertFormatting on IntruderAlert {
  String _locale(BuildContext context) =>
      Localizations.localeOf(context).toLanguageTag();

  /// Attempted app name, or "Main Unlock" when the alert came from App Lock.
  String displayTitle(BuildContext context) {
    final name = appName;
    if (name == null || name.trim().isEmpty) {
      return context.l10n.intruderMainUnlock;
    }
    return name;
  }

  String methodLabel(BuildContext context) =>
      method.localizedLabel(context.l10n);

  /// Short label for list cards: time for today, "Yesterday", or a date.
  String shortTimeLabel(BuildContext context) {
    final locale = _locale(context);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(createdAt.year, createdAt.month, createdAt.day);
    final diff = today.difference(day).inDays;
    if (diff == 0) return DateFormat.jm(locale).format(createdAt);
    if (diff == 1) return context.l10n.intruderYesterday;
    if (createdAt.year == now.year) {
      return DateFormat.MMMd(locale).format(createdAt);
    }
    return DateFormat.yMMMd(locale).format(createdAt);
  }

  /// Full date and time label for the detail view.
  String fullDateTimeLabel(BuildContext context) {
    final locale = _locale(context);
    return DateFormat.yMMMd(locale).add_jm().format(createdAt);
  }
}

extension IntruderUnlockMethodLabel on IntruderUnlockMethod {
  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case IntruderUnlockMethod.pin:
        return l10n.intruderMethodPin;
      case IntruderUnlockMethod.pattern:
        return l10n.intruderMethodPattern;
      case IntruderUnlockMethod.biometric:
        return l10n.intruderMethodBiometric;
    }
  }
}
