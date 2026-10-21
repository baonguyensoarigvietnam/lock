class LockConfig {
  final String? pinCode;
  final String? pattern;
  final bool isBiometricEnabled;
  final bool isServiceActive;

  const LockConfig({
    this.pinCode,
    this.pattern,
    this.isBiometricEnabled = false,
    this.isServiceActive = false,
  });

  bool get hasPinCode => pinCode != null && pinCode!.isNotEmpty;

  bool get hasPattern => pattern != null && pattern!.isNotEmpty;

  LockConfig copyWith({
    String? pinCode,
    String? pattern,
    bool? isBiometricEnabled,
    bool? isServiceActive,
  }) {
    return LockConfig(
      pinCode: pinCode ?? this.pinCode,
      pattern: pattern ?? this.pattern,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      isServiceActive: isServiceActive ?? this.isServiceActive,
    );
  }
}
