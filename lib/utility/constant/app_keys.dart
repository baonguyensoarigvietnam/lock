import 'dart:io' show Platform;

/// Compile-time flag for AdMob production mode
/// Use `--dart-define=ADMOB_PRODUCTION=true` for production builds
const bool isAdMobProduction = bool.fromEnvironment(
  'ADMOB_PRODUCTION',
  defaultValue: false,
);

/// This class contains all the application keys
class AppKeys {
  const AppKeys._();

  static const iap = _IAP();
  static const admob = _AdMob();
}

/// In App Purchase keys
final class _IAP {
  const _IAP();

  // Base group subscription ID in App Store (iOS)
  final String iosBaseGroup = 'com.hikoni.ailanguagetranslator.iap.premium';

  // Base group subscription ID in Google Play Console (Android) - Max 40 chars limit
  final String androidBaseGroup = 'com.hikoni.ailanguagetranslator.iap.prem';

  // Product IDs for iOS
  String get monthly => '$iosBaseGroup.monthly';
  String get yearly => '$iosBaseGroup.yearly';

  // Base plan IDs for Android Google Play Console
  String get androidMonthlyPlanId => 'monthly';
  String get androidYearlyPlanId => 'yearly';

  /// Get active base group according to platform
  String get activeBaseGroup =>
      Platform.isAndroid ? androidBaseGroup : iosBaseGroup;

  Set<String> get productIds {
    if (Platform.isAndroid) {
      return {androidBaseGroup};
    }
    return {monthly, yearly};
  }
}

/// AdMob keys - uses compile-time flag for environment selection
final class _AdMob {
  const _AdMob();

  // ============== TEST IDs (Google Official) ==============
  // Android Test App ID: ca-app-pub-3940256099942544~3347511713
  // iOS Test App ID: ca-app-pub-3940256099942544~1458002511

  // Android Test Ad Unit IDs
  static const String _testBannerAndroid =
      'ca-app-pub-3940256099942544/9214589741';
  static const String _testInterstitialAndroid =
      'ca-app-pub-3940256099942544/1033173712';
  static const String _testAppOpenAndroid =
      'ca-app-pub-3940256099942544/9257395921';
  static const String _testRewardAndroid =
      'ca-app-pub-3940256099942544/5224354917';
  static const String _testNativeAndroid =
      'ca-app-pub-3940256099942544/2247696110';

  // iOS Test Ad Unit IDs
  static const String _testBannerIOS = 'ca-app-pub-3940256099942544/2435281174';
  static const String _testInterstitialIOS =
      'ca-app-pub-3940256099942544/4411468910';
  static const String _testAppOpenIOS =
      'ca-app-pub-3940256099942544/5575463023';
  static const String _testRewardIOS = 'ca-app-pub-3940256099942544/1712485313';
  static const String _testNativeIOS = 'ca-app-pub-3940256099942544/3986624511';

  // ============== PRODUCTION IDs (Replace with your actual IDs) ==============
  // TODO: Replace these with your production Ad Unit IDs

  // Android Production Ad Unit IDs
  static const String _prodBannerAndroid =
      'ca-app-pub-6329015907121776/7917293667';
  static const String _prodInterstitialAndroid =
      'ca-app-pub-6329015907121776/9539045254';
  static const String _prodAppOpenAndroid =
      'ca-app-pub-6329015907121776/5408228554';
  static const String _prodRewardAndroid = ''; // No reward ad in Android
  static const String _prodNativeAndroid =
      'ca-app-pub-6329015907121776/1931571838';

  // iOS Production Ad Unit IDs
  static const String _prodBannerIOS = 'ca-app-pub-6329015907121776/9511125092';
  static const String _prodInterstitialIOS =
      'ca-app-pub-6329015907121776/5092799715';
  static const String _prodAppOpenIOS =
      'ca-app-pub-6329015907121776/9501838075';
  static const String _prodRewardIOS = ''; // No reward ad in iOS
  static const String _prodNativeIOS = 'ca-app-pub-6329015907121776/2988668488';

  /// Select correct ad unit ID based on environment and platform
  String _getAdUnitId({
    required String prodAndroid,
    required String testAndroid,
    required String prodIOS,
    required String testIOS,
  }) {
    if (Platform.isIOS) {
      return isAdMobProduction ? prodIOS : testIOS;
    }
    return isAdMobProduction ? prodAndroid : testAndroid;
  }

  String get banner => _getAdUnitId(
    prodAndroid: _prodBannerAndroid,
    testAndroid: _testBannerAndroid,
    prodIOS: _prodBannerIOS,
    testIOS: _testBannerIOS,
  );

  String get interstitial => _getAdUnitId(
    prodAndroid: _prodInterstitialAndroid,
    testAndroid: _testInterstitialAndroid,
    prodIOS: _prodInterstitialIOS,
    testIOS: _testInterstitialIOS,
  );

  String get appOpen => _getAdUnitId(
    prodAndroid: _prodAppOpenAndroid,
    testAndroid: _testAppOpenAndroid,
    prodIOS: _prodAppOpenIOS,
    testIOS: _testAppOpenIOS,
  );

  String get reward => _getAdUnitId(
    prodAndroid: _prodRewardAndroid,
    testAndroid: _testRewardAndroid,
    prodIOS: _prodRewardIOS,
    testIOS: _testRewardIOS,
  );

  String get native => _getAdUnitId(
    prodAndroid: _prodNativeAndroid,
    testAndroid: _testNativeAndroid,
    prodIOS: _prodNativeIOS,
    testIOS: _testNativeIOS,
  );
}
