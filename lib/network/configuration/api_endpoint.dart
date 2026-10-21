import 'package:applock/network/configuration/network_configuration.dart';

final class HubEndpoint {
  const HubEndpoint._();

  static String get baseUrl => '${NetworkConfiguration.hubApiUrl}/api/v1';

  static const String frequency = '/apps/frequency';
  static const String installs = '/installs';
  static const String ads = '/apps/ads';
  static const String adsEvent = '/apps/ads-event';
}
