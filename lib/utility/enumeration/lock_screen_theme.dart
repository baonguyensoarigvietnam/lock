/// Look & behaviour of the lock screen, chosen in Home > Themes.
enum LockScreenTheme {
  /// Generic lock icon instead of the protected app's icon.
  minimal(storageKey: 'minimal'),

  /// Always opens on the PIN keypad.
  classicPin(storageKey: 'classicPin'),

  /// Opens on the pattern grid when a pattern is set.
  pattern(storageKey: 'pattern'),

  /// Default: protected app icon + name.
  vault(storageKey: 'vault'),

  /// Privacy: hides which app is being unlocked.
  focus(storageKey: 'focus');

  const LockScreenTheme({required this.storageKey});

  final String storageKey;

  static LockScreenTheme fromStorageKey(String? key) {
    return LockScreenTheme.values.firstWhere(
      (e) => e.storageKey == key,
      orElse: () => LockScreenTheme.vault,
    );
  }
}
