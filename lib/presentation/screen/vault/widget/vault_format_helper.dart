import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:applock/domain/model/vault_item.dart';
import 'package:applock/utility/extension/build_context.dart';

/// Locale-aware formatting helpers for vault metadata.
abstract final class VaultFormatHelper {
  static String _locale(BuildContext context) =>
      Localizations.localeOf(context).toString();

  /// Formats a date like `Oct 24, 2023` in the current locale.
  static String date(BuildContext context, DateTime date) =>
      DateFormat.yMMMd(_locale(context)).format(date);

  /// Formats a byte count like `12.4 MB` in the current locale.
  static String fileSize(BuildContext context, int bytes) {
    final l10n = context.l10n;
    final number = NumberFormat('#,##0.#', _locale(context));
    const kb = 1024;
    const mb = kb * 1024;
    const gb = mb * 1024;
    if (bytes >= gb) return l10n.vaultSizeGb(number.format(bytes / gb));
    if (bytes >= mb) return l10n.vaultSizeMb(number.format(bytes / mb));
    if (bytes >= kb) return l10n.vaultSizeKb(number.format(bytes / kb));
    return l10n.vaultSizeBytes(number.format(bytes));
  }

  /// `date • size` subtitle for list/grid items.
  static String itemSubtitle(BuildContext context, VaultItem item) =>
      context.l10n.vaultItemSubtitle(
        date(context, item.createdAt),
        fileSize(context, item.sizeBytes),
      );

  /// Human-readable file type: extension (e.g. `JPG`) or localized type.
  static String fileType(BuildContext context, VaultItem item) {
    if (item.extension.isNotEmpty) return item.extension;
    return item.isVideo
        ? context.l10n.vaultTypeVideo
        : context.l10n.vaultTypePhoto;
  }

  /// Formats a playback duration as `mm:ss` (or `h:mm:ss`).
  static String duration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return hours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
  }
}
