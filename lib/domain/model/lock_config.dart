class LockConfig {
  final String? pinCode;
  final bool isBiometricEnabled;
  final bool isServiceActive;

  const LockConfig({
    this.pinCode,
    this.isBiometricEnabled = false,
    this.isServiceActive = false,
  });

  bool get hasPinCode => pinCode != null && pinCode!.isNotEmpty;

  LockConfig copyWith({
    String? pinCode,
    bool? isBiometricEnabled,
    bool? isServiceActive,
  }) {
    return LockConfig(
      pinCode: pinCode ?? this.pinCode,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      isServiceActive: isServiceActive ?? this.isServiceActive,
    );
  }
}
