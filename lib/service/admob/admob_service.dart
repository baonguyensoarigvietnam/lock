import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';
import 'package:applock/service/admob/admob_device.dart';
import 'package:applock/utility/constant/app_keys.dart';

@lazySingleton
class AdmobService {
  /// Admob error code
  static const int _networkErrorCode = 2;
  static const int _noFillErrorCode = 3;

  /// Retry count
  static const int _bannerMaxRetryCount = 1;
  static const int _interstitialMaxRetryCount = 1;
  static const int _appOpenAdMaxRetryCount = 1;
  static const int _rewardedAdMaxRetryCount = 1;

  /// Retry delay
  static const Duration _bannerRetryDelay = Duration(milliseconds: 1500);
  static const Duration _fullscreenRetryDelay = Duration(milliseconds: 500);

  /// Minimum interval between two consecutive fullscreen ad impressions.
  static const Duration _appOpenAdMinInterval = Duration(seconds: 30);
  static const Duration _interstitialAdMinInterval = Duration(seconds: 20);

  /// State
  bool _isInitialized = false;
  bool _isPro = false;

  bool _isInterstitialAdLoading = false;
  bool _isInterstitialAdShowing = false;
  int _interstitialRetryCount = 0;
  InterstitialAd? _interstitialAd;

  // App Open Ad state
  AppOpenAd? _appOpenAd;
  bool _isAppOpenAdLoading = false;
  bool _isAppOpenAdShowing = false;
  DateTime? _lastAppOpenAdShownAt;
  int _appOpenAdRetryCount = 0;

  // Rewarded Ad state
  RewardedAd? _rewardedAd;
  bool _isRewardedAdLoading = false;
  bool _isRewardedAdShowing = false;
  int _rewardedAdRetryCount = 0;

  // Interstitial Ad state
  int fullscreenAdRandomness = 1;
  DateTime? _lastInterstitialAdShownAt;

  // Getters
  bool get isPro => _isPro;
  bool get hasInterstitialAd => _interstitialAd != null;
  bool get hasRewardedAd => _rewardedAd != null;
  bool get hasInitialized => _isInitialized;
  bool get isFullscreenAdShowing =>
      _isRewardedAdShowing || _isInterstitialAdShowing || _isAppOpenAdShowing;

  /// Initialize admob
  Future<void> init(bool isInitiallyPro) async {
    if (_isInitialized) return;

    _isPro = isInitiallyPro;

    if (!_isPro) {
      await _initMobileAds();
    }
  }

  /// Update pro status
  void updateProStatus(bool isPro) {
    if (_isPro == isPro) return;
    _isPro = isPro;

    if (_isPro) {
      _disposeCachedFullscreenAds();
    } else {
      if (!_isInitialized) {
        _initMobileAds().then((_) {
          _isInitialized = true;
          preloadInterstitialAd();
          preloadAppOpenAd();
          preloadRewardedAd();
        });
      }
    }
  }

  Future<void> preloadInterstitialAd() async {
    if (!_isInitialized) {
      log('AdmobService.init() has not been called yet.');
      return;
    }

    if (_isPro || _isInterstitialAdLoading || _interstitialAd != null) {
      return;
    }

    _isInterstitialAdLoading = true;

    InterstitialAd.load(
      adUnitId: AppKeys.admob.interstitial,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          _isInterstitialAdLoading = false;
          _interstitialRetryCount = 0;
        },
        onAdFailedToLoad: (error) {
          if (_shouldStopRetry(
            error.code,
            _interstitialRetryCount,
            _interstitialMaxRetryCount,
          )) {
            _isInterstitialAdLoading = false;
            log('Interstitial ad failed to load: $error');
            return;
          }

          _interstitialRetryCount++;
          Future<void>.delayed(_fullscreenRetryDelay, preloadInterstitialAd);
        },
      ),
    );
  }

  /// Show interstitial ad
  Future<void> showInterstitialAd({VoidCallback? onDismiss}) async {
    if (!_isInitialized || _isPro || isFullscreenAdShowing) {
      onDismiss?.call();
      return;
    }

    final lastShown = _lastInterstitialAdShownAt;
    if (lastShown != null &&
        DateTime.now().difference(lastShown) < _interstitialAdMinInterval) {
      onDismiss?.call();
      return;
    }

    if (!_passesFullscreenRandomness()) {
      onDismiss?.call();
      return;
    }

    final ad = _interstitialAd;
    if (ad == null) {
      _interstitialRetryCount = 0;
      preloadInterstitialAd();
      onDismiss?.call();
      return;
    }

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) {
        _isInterstitialAdShowing = true;
      },
      onAdDismissedFullScreenContent: (dismissedAd) {
        dismissedAd.dispose();
        _isInterstitialAdShowing = false;
        _interstitialAd = null;
        _interstitialRetryCount = 0;
        _lastInterstitialAdShownAt = DateTime.now();
        onDismiss?.call();
        preloadInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (failedAd, error) {
        _isInterstitialAdShowing = false;
        failedAd.dispose();
        _interstitialAd = null;
        onDismiss?.call();
        log('Interstitial ad failed to show: $error');
      },
    );

    ad.show();
  }

  // -- App Open Ad --

  void preloadAppOpenAd({bool showAfterLoad = false}) {
    if (!_isInitialized) {
      log('AdmobService.init() has not been called yet.');
      return;
    }

    if (_isPro || _isAppOpenAdLoading || _appOpenAd != null) return;

    _isAppOpenAdLoading = true;

    AppOpenAd.load(
      adUnitId: AppKeys.admob.appOpen,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          log('App open ad loaded.');
          _appOpenAd = ad;
          _isAppOpenAdLoading = false;
          _appOpenAdRetryCount = 0;

          if (showAfterLoad) {
            showAppOpenAd();
          }
        },
        onAdFailedToLoad: (error) {
          log('App open ad failed to load: $error');
          _isAppOpenAdLoading = false;
          _appOpenAd = null;

          if (!_shouldStopRetry(
            error.code,
            _appOpenAdRetryCount,
            _appOpenAdMaxRetryCount,
          )) {
            _appOpenAdRetryCount++;
            Future<void>.delayed(_fullscreenRetryDelay, preloadAppOpenAd);
          }
        },
      ),
    );
  }

  void showAppOpenAd({
    VoidCallback? onAdFailedToShow,
    VoidCallback? onAdDismissed,
  }) {
    if (!_isInitialized || _isPro || isFullscreenAdShowing) {
      onAdDismissed?.call();
      return;
    }

    final lastShown = _lastAppOpenAdShownAt;
    if (lastShown != null &&
        DateTime.now().difference(lastShown) < _appOpenAdMinInterval) {
      log('App open ad skipped: cooldown not elapsed.');
      return;
    }

    final ad = _appOpenAd;
    if (ad == null) {
      preloadAppOpenAd();
      onAdFailedToShow?.call();
      return;
    }

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) {
        _isAppOpenAdShowing = true;
        log('App open ad shown.');
      },
      onAdDismissedFullScreenContent: (dismissedAd) {
        _isAppOpenAdShowing = false;
        dismissedAd.dispose();
        _appOpenAd = null;
        _lastAppOpenAdShownAt = DateTime.now();
        preloadAppOpenAd();
        log('App open ad dismissed.');
        onAdDismissed?.call();
      },
      onAdFailedToShowFullScreenContent: (failedAd, error) {
        _isAppOpenAdShowing = false;
        failedAd.dispose();
        _appOpenAd = null;
        log('App open ad failed to show: $error');
        preloadAppOpenAd();
        onAdFailedToShow?.call();
      },
    );

    ad.show();
  }

  // -- Rewarded Ad --

  void preloadRewardedAd() {
    if (!_isInitialized) {
      log('AdmobService.init() has not been called yet.');
      return;
    }

    if (_isPro || _isRewardedAdLoading || _rewardedAd != null) return;

    final rewardId = AppKeys.admob.reward;
    if (rewardId.isEmpty) return;

    _isRewardedAdLoading = true;

    RewardedAd.load(
      adUnitId: rewardId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          log('Rewarded ad loaded.');
          _rewardedAd = ad;
          _isRewardedAdLoading = false;
          _rewardedAdRetryCount = 0;
        },
        onAdFailedToLoad: (error) {
          log('Rewarded ad failed to load: $error');
          _isRewardedAdLoading = false;
          _rewardedAd = null;

          if (!_shouldStopRetry(
            error.code,
            _rewardedAdRetryCount,
            _rewardedAdMaxRetryCount,
          )) {
            _rewardedAdRetryCount++;
            Future<void>.delayed(_fullscreenRetryDelay, preloadRewardedAd);
          }
        },
      ),
    );
  }

  void showRewardedAd({
    required VoidCallback onRewarded,
    VoidCallback? onDismiss,
    VoidCallback? onFailedToShow,
  }) {
    if (!_isInitialized || _isPro || isFullscreenAdShowing) {
      onFailedToShow?.call();
      return;
    }

    final ad = _rewardedAd;
    if (ad == null) {
      _rewardedAdRetryCount = 0;
      preloadRewardedAd();
      onFailedToShow?.call();
      return;
    }

    bool rewarded = false;

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) {
        _isRewardedAdShowing = true;
        log('Rewarded ad shown.');
      },
      onAdDismissedFullScreenContent: (dismissedAd) {
        _isRewardedAdShowing = false;
        dismissedAd.dispose();
        _rewardedAd = null;
        _rewardedAdRetryCount = 0;
        preloadRewardedAd();
        log('Rewarded ad dismissed.');
        if (rewarded) {
          onRewarded();
        }
        onDismiss?.call();
      },
      onAdFailedToShowFullScreenContent: (failedAd, error) {
        _isRewardedAdShowing = false;
        failedAd.dispose();
        _rewardedAd = null;
        log('Rewarded ad failed to show: $error');
        preloadRewardedAd();
        onFailedToShow?.call();
      },
    );

    ad.show(
      onUserEarnedReward: (_, reward) {
        log('User earned reward: ${reward.amount} ${reward.type}');
        rewarded = true;
      },
    );
  }

  // -- Banner Ad --

  BannerAd createBannerAd({
    required AdSize adSize,
    VoidCallback? onLoaded,
    ValueChanged<LoadAdError>? onFailed,
  }) {
    int retryCount = 0;

    late final BannerAd bannerAd;
    bannerAd = BannerAd(
      adUnitId: AppKeys.admob.banner,
      size: adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          retryCount = 0;
          log('Banner ad loaded');
          onLoaded?.call();
        },
        onAdFailedToLoad: (ad, error) {
          log('Banner ad failed to load: $error');
          if (_isPro ||
              _shouldStopRetry(error.code, retryCount, _bannerMaxRetryCount)) {
            ad.dispose();
            onFailed?.call(error);
            return;
          }

          retryCount++;
          Future<void>.delayed(_bannerRetryDelay, () {
            if (_isPro) {
              ad.dispose();
              return;
            }
            bannerAd.load();
          });
        },
      ),
    );

    if (_isInitialized && !_isPro) {
      bannerAd.load();
    } else if (!_isInitialized) {
      log('AdmobService.init() has not been called yet.');
    }

    return bannerAd;
  }

  void disposeBannerAd(BannerAd? ad) {
    ad?.dispose();
  }

  // -- Native Ad --

  NativeAd createNativeAd({
    required NativeTemplateStyle nativeTemplateStyle,
    VoidCallback? onLoaded,
    ValueChanged<LoadAdError>? onFailed,
  }) {
    int retryCount = 0;

    late final NativeAd nativeAd;
    nativeAd = NativeAd(
      adUnitId: AppKeys.admob.native,
      request: const AdRequest(),
      nativeTemplateStyle: nativeTemplateStyle,
      customOptions: {'gma_native_template_custom_options': 'true'},
      listener: NativeAdListener(
        onAdLoaded: (_) {
          retryCount = 0;
          log('Native ad loaded');
          onLoaded?.call();
        },
        onAdFailedToLoad: (ad, error) {
          log('Native ad failed to load: $error');
          if (_isPro ||
              _shouldStopRetry(error.code, retryCount, _bannerMaxRetryCount)) {
            ad.dispose();
            onFailed?.call(error);
            return;
          }

          retryCount++;
          Future<void>.delayed(_bannerRetryDelay, () {
            if (_isPro) {
              ad.dispose();
              return;
            }
            nativeAd.load();
          });
        },
      ),
    );

    if (_isInitialized && !_isPro) {
      nativeAd.load();
    } else if (!_isInitialized) {
      log('AdmobService.init() has not been called yet.');
    }

    return nativeAd;
  }

  void disposeNativeAd(NativeAd? ad) {
    ad?.dispose();
  }

  Future<void> _initMobileAds() async {
    try {
      await MobileAds.instance.initialize();
      await MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(testDeviceIds: AdmobDevice.testDeviceIds),
      );
      _isInitialized = true;
    } catch (e) {
      log('AdmobService._initMobileAds failed: $e');
    }
  }

  bool _passesFullscreenRandomness() {
    if (fullscreenAdRandomness <= 1) return true;
    final randomValue =
        1 + DateTime.now().microsecondsSinceEpoch % fullscreenAdRandomness;
    return randomValue == 1;
  }

  bool _shouldStopRetry(
    int errorCode,
    int currentRetryCount,
    int maxRetryCount,
  ) {
    return errorCode == _networkErrorCode ||
        errorCode == _noFillErrorCode ||
        currentRetryCount >= maxRetryCount;
  }

  void _disposeCachedFullscreenAds() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _isInterstitialAdLoading = false;
    _isInterstitialAdShowing = false;
    _interstitialRetryCount = 0;

    _appOpenAd?.dispose();
    _appOpenAd = null;
    _isAppOpenAdLoading = false;
    _isAppOpenAdShowing = false;
    _appOpenAdRetryCount = 0;

    _rewardedAd?.dispose();
    _rewardedAd = null;
    _isRewardedAdLoading = false;
    _isRewardedAdShowing = false;
    _rewardedAdRetryCount = 0;
  }

  @disposeMethod
  void dispose() {
    _disposeCachedFullscreenAds();
  }
}
