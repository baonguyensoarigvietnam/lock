import 'package:flutter/material.dart' show BuildContext, MediaQuery;
import 'package:applock/l10n/app_localizations.dart';
import 'package:applock/utility/enumeration/device_type.dart' show DeviceType;

extension LocalizationHelper on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension ResponsiveHelper on BuildContext {
  static const double _tabletBreakpoint = 600;
  static const double _smallMobileBreakpoint = 380;

  double get _shortestSide => MediaQuery.sizeOf(this).shortestSide;

  DeviceType get deviceType {
    if (_shortestSide >= _tabletBreakpoint) return DeviceType.tablet;
    if (_shortestSide < _smallMobileBreakpoint) return DeviceType.smallMobile;
    return DeviceType.mobile;
  }

  bool get isTablet => deviceType == DeviceType.tablet;

  bool get isSmallMobile => deviceType == DeviceType.smallMobile;

  bool get isMobile => deviceType == DeviceType.mobile;

  /// Returns a value [T] based on the device's screen size (shortestSide).
  T lp<T>(T mobile, {T? tablet, T? smallMobile}) {
    final double shortestSide = MediaQuery.sizeOf(this).shortestSide;

    if (shortestSide >= _tabletBreakpoint) {
      return tablet ?? mobile;
    }

    if (isSmallMobile && smallMobile != null) {
      return smallMobile;
    }

    return mobile;
  }
}
