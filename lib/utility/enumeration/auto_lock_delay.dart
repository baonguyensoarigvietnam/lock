import 'package:applock/l10n/app_localizations.dart';

/// How long an unlocked app stays unlocked after the user leaves it.
enum AutoLockDelay {
  immediately(storageKey: 'immediately', delayMs: 0),
  seconds15(storageKey: 'seconds15', delayMs: 15000),
  seconds30(storageKey: 'seconds30', delayMs: 30000),
  minute1(storageKey: 'minute1', delayMs: 60000),
  screenOff(storageKey: 'screenOff', delayMs: 0, relockOnScreenOff: true);

  const AutoLockDelay({
    required this.storageKey,
    required this.delayMs,
    this.relockOnScreenOff = false,
  });

  final String storageKey;
  final int delayMs;
  final bool relockOnScreenOff;

  String label(AppLocalizations l10n) {
    switch (this) {
      case AutoLockDelay.immediately:
        return l10n.delayImmediately;
      case AutoLockDelay.seconds15:
        return l10n.delay15Seconds;
      case AutoLockDelay.seconds30:
        return l10n.delay30Seconds;
      case AutoLockDelay.minute1:
        return l10n.delay1Minute;
      case AutoLockDelay.screenOff:
        return l10n.delayScreenOff;
    }
  }

  static AutoLockDelay fromStorageKey(String? key) {
    return AutoLockDelay.values.firstWhere(
      (e) => e.storageKey == key,
      orElse: () => AutoLockDelay.immediately,
    );
  }
}
