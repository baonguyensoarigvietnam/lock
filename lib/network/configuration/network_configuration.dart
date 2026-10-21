import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Providing access to network secret properties
final class NetworkConfiguration {
  const NetworkConfiguration._();

  static String get hubApiUrl => dotenv.env['HUB_BASE_URL'] ?? '';
  static String get hubApiKey => dotenv.env['HUB_API_KEY'] ?? '';
}
