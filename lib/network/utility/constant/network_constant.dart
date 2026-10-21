final class NetworkConstant {
  const NetworkConstant._();

  static const pagination = 'pagination';
  static const retryCount = 'retryCount';
  static const refreshed = 'refreshed';

  // Annotation keys
  static const skipEnvelope = 'skipEnvelopeKey';
  static const skipAuthApi = 'skipAuthApiKey';
  static const injectHubQuery = 'injectHubQueryKey';
  static const injectHubBodyHostAppId = 'injectHubBodyHostAppIdKey';
  static const injectHubBodyAppId = 'injectHubBodyAppIdKey';

  // Headers
  static const apiKeyHeader = 'X-API-KEY';
  static const authorizationHeader = 'Authorization';

  // Request & Params keys
  static const appIdKey = 'app_id';
  static const hostAppIdKey = 'host_app_id';
  static const platformKey = 'platform';

  // Platform values
  static const platformIOS = 'IOS';
  static const platformAndroid = 'ANDROID';
}
