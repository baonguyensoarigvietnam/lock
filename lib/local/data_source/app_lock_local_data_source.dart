import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class AppLockLocalDataSource {
  final SharedPreferences _preferences;

  static const String _keyLockedPackages = 'applock_locked_packages';
  static const String _keyPinCode = 'applock_pin_code';
  static const String _keyPattern = 'applock_pattern';
  static const String _keyBiometricEnabled = 'applock_biometric_enabled';
  static const String _keyServiceActive = 'applock_service_active';
  static const String _keyOnboardingCompleted = 'applock_onboarding_completed';
  static const String _keyLanguageCode = 'applock_language_code';

  AppLockLocalDataSource(this._preferences);

  String getLanguageCode() {
    return _preferences.getString(_keyLanguageCode) ?? 'en';
  }

  Future<bool> setLanguageCode(String code) {
    return _preferences.setString(_keyLanguageCode, code);
  }

  bool isOnboardingCompleted() {
    return _preferences.getBool(_keyOnboardingCompleted) ?? false;
  }

  Future<bool> setOnboardingCompleted(bool completed) {
    return _preferences.setBool(_keyOnboardingCompleted, completed);
  }

  static const List<String> _defaultLockedPackages = [
    'com.android.gallery3d',
    'com.google.android.apps.messaging',
    'com.google.android.apps.photos',
    'com.android.banking',
    'com.android.contacts',
  ];

  Set<String> getLockedPackages() {
    final list = _preferences.getStringList(_keyLockedPackages);
    if (list == null) {
      return _defaultLockedPackages.toSet();
    }
    return list.toSet();
  }

  Future<bool> setLockedPackages(Set<String> packages) {
    return _preferences.setStringList(_keyLockedPackages, packages.toList());
  }

  String? getPinCode() {
    return _preferences.getString(_keyPinCode);
  }

  Future<bool> setPinCode(String pin) {
    return _preferences.setString(_keyPinCode, pin);
  }

  String? getPattern() {
    return _preferences.getString(_keyPattern);
  }

  Future<bool> setPattern(String pattern) {
    return _preferences.setString(_keyPattern, pattern);
  }

  bool isBiometricEnabled() {
    return _preferences.getBool(_keyBiometricEnabled) ?? false;
  }

  Future<bool> setBiometricEnabled(bool enabled) {
    return _preferences.setBool(_keyBiometricEnabled, enabled);
  }

  bool isServiceActive() {
    return _preferences.getBool(_keyServiceActive) ?? false;
  }

  Future<bool> setServiceActive(bool active) {
    return _preferences.setBool(_keyServiceActive, active);
  }
}
