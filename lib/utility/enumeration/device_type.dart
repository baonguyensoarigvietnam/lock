import 'dart:io';

enum DeviceType {
  smallMobile,
  mobile,
  tablet,
  desktop,
  web;

  static bool get isMobile => Platform.isAndroid || Platform.isIOS;
}
