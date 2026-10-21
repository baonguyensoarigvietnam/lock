import 'dart:io';

enum DeviceType {
  mobile,
  tablet,
  desktop,
  web;

  static bool get isMobile => Platform.isAndroid || Platform.isIOS;
}
