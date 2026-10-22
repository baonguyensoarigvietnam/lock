import 'dart:async';
import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:injectable/injectable.dart';
import 'package:applock/application/lifecycle/app_lifecycle_observer.dart';
import 'package:applock/application/view_model/global_view_model_state.dart';
import 'package:applock/domain/model/advertisement.dart';
import 'package:applock/domain/repository/ad_repository.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/domain/repository/app_tracking_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/service/admob/admob_service.dart';
import 'package:applock/service/notification/fcm_service.dart';
import 'package:applock/service/permission/permission_service.dart';
import 'package:applock/service/purchase/purchase_service.dart';
import 'package:applock/utility/enumeration/app_language.dart';
import 'package:applock/utility/helper/nullable.dart';
import 'package:applock/utility/helper/result.dart';

@lazySingleton
class GlobalViewModel extends BaseCubit<GlobalViewModelState> {
  final AppLockRepository _repository;
  final PermissionService _permissionService;
  final PurchaseService _purchaseService;
  final AdmobService _admobService;
  final FcmService _fcmService;
  final AppTrackingRepository _appTrackingRepository;
  final AdRepository _adRepository;
  final AppLifecycleObserver _lifecycleObserver;

  StreamSubscription<bool>? _premiumSubscription;
  StreamSubscription<AppLifecycleState>? _lifecycleSubscription;
  StreamSubscription<String>? _fcmTokenSubscription;

  GlobalViewModel(
    this._repository,
    this._permissionService,
    this._purchaseService,
    this._admobService,
    this._fcmService,
    this._appTrackingRepository,
    this._adRepository,
    this._lifecycleObserver,
  ) : super(const GlobalViewModelState());

  bool get isPro => state.isPremium;

  Future<void> init() async {
    _initPremium();

    final configResult = await _repository.getLockConfig();
    final langResult = await _repository.getLanguageCode();
    final isOverlay = await _permissionService.isOverlayPermissionGranted();

    var savedLocale = state.locale;
    if (langResult case Success<String>(data: final code)) {
      savedLocale = AppLanguage.fromCode(code).locale;
    }

    switch (configResult) {
      case Success(data: final config):
        emit(state.copyWith(
          locale: savedLocale,
          lockConfig: config,
          isOverlayGranted: isOverlay,
        ));
      case Error():
        emit(state.copyWith(
          locale: savedLocale,
          isOverlayGranted: isOverlay,
        ));
    }

    await _initAdmob();

    if (!isPro) {
      unawaited(_loadFullscreenAdFrequency());
      _startAppOpenAdLifecycle();
    }

    unawaited(_trackInstallAndUpdateToken());
  }

  Future<void> setLocale(Locale locale) async {
    emit(state.copyWith(locale: locale));
    await _repository.saveLanguageCode(locale.languageCode);
  }

  Future<void> setLanguage(AppLanguage language) async {
    await setLocale(language.locale);
  }

  Future<void> refreshPermissions() async {
    final isOverlay = await _permissionService.isOverlayPermissionGranted();
    emit(state.copyWith(isOverlayGranted: isOverlay));
  }

  /// Re-syncs the Premium entitlement with the store (keeps the cached value
  /// when offline) and emits it.
  Future<void> refreshPremium() async {
    final isPremium = await _purchaseService.refreshEntitlement();
    if (isClosed) return;
    _onPremiumChanged(isPremium);
  }

  void _initPremium() {
    _purchaseService.initialize();
    emit(state.copyWith(isPremium: _purchaseService.isPremium));
    _premiumSubscription ??= _purchaseService.premiumStream.listen((value) {
      if (isClosed) return;
      _onPremiumChanged(value);
    });
    unawaited(refreshPremium());
  }

  void _onPremiumChanged(bool isPremium) {
    final changed = state.isPremium != isPremium;
    _admobService.updateProStatus(isPremium);
    emit(state.copyWith(
      isPremium: isPremium,
      isAdmobReady: !isPremium && _admobService.hasInitialized,
      advertisement: isPremium ? const Nullable(null) : null,
    ));

    if (changed) {
      if (isPremium) {
        _lifecycleSubscription?.cancel();
      } else {
        _startAppOpenAdLifecycle();
      }
    }
  }

  /// Pause trigger to show App Open Ad
  void pauseAdOpenTrigger() {
    _lifecycleObserver.lockAdTrigger();
  }

  /// Resume trigger to show App Open Ad
  void resumeAdOpenTrigger() {
    _lifecycleObserver.unlockAdTrigger();
  }

  /// Creates and returns a [BannerAd]. Delegates to [AdmobService].
  BannerAd createBannerAd({
    required AdSize adSize,
    VoidCallback? onLoaded,
    ValueChanged<LoadAdError>? onFailed,
  }) => _admobService.createBannerAd(
    adSize: adSize,
    onLoaded: onLoaded,
    onFailed: onFailed,
  );

  /// Disposes a [BannerAd] created via [createBannerAd].
  void disposeBannerAd(BannerAd? ad) => _admobService.disposeBannerAd(ad);

  /// Creates and returns a [NativeAd]. Delegates to [AdmobService].
  NativeAd createNativeAd({
    required NativeTemplateStyle nativeTemplateStyle,
    VoidCallback? onLoaded,
    ValueChanged<LoadAdError>? onFailed,
  }) => _admobService.createNativeAd(
    nativeTemplateStyle: nativeTemplateStyle,
    onLoaded: onLoaded,
    onFailed: onFailed,
  );

  /// Disposes a [NativeAd] created via [createNativeAd].
  void disposeNativeAd(NativeAd? ad) => _admobService.disposeNativeAd(ad);

  /// Show interstitial ad with callback when ad is dismissed
  Future<void> showInterstitialAd({VoidCallback? onDismiss}) async {
    pauseAdOpenTrigger();

    emit(state.copyWith(showInterstitialAd: true));

    await _admobService.showInterstitialAd(
      onDismiss: () {
        Future.delayed(const Duration(milliseconds: 500), () {
          resumeAdOpenTrigger();
        });
        onDismiss?.call();
      },
    );

    if (!isClosed) {
      emit(state.copyWith(showInterstitialAd: false));
    }
  }

  /// Preload a rewarded ad so it is ready to show instantly.
  void preloadRewardedAd() => _admobService.preloadRewardedAd();

  /// Show a rewarded ad.
  void showRewardedAd({
    required VoidCallback onRewarded,
    VoidCallback? onDismiss,
    VoidCallback? onFailedToShow,
  }) {
    pauseAdOpenTrigger();
    _admobService.showRewardedAd(
      onRewarded: onRewarded,
      onDismiss: () {
        onDismiss?.call();
        Future.delayed(const Duration(milliseconds: 500), () {
          resumeAdOpenTrigger();
        });
      },
      onFailedToShow: () {
        onFailedToShow?.call();
        resumeAdOpenTrigger();
      },
    );
  }

  /// Fetches a cross-promotion advertisement from the Central Hub.
  Future<void> loadCrossPromotionAd() async {
    if (state.isPremium) return;

    final result = await _adRepository.getCrossPromotionAd();
    if (isClosed || state.isPremium) return;

    if (result is Success<Advertisement>) {
      emit(state.copyWith(advertisement: Nullable(result.data)));
    }
  }

  /// Clears active advertisement from state.
  void clearAdvertisement() {
    emit(state.copyWith(advertisement: const Nullable(null)));
  }

  /// Sends an interaction event (click, skip) for an advertisement.
  Future<void> sendAdEvent({
    required String targetAppId,
    required AdEvent event,
  }) async {
    await _adRepository.sendAdEvent(targetAppId: targetAppId, event: event);
  }

  Future<void> _initAdmob() async {
    await _admobService.init(isPro);
    if (!isClosed) {
      emit(state.copyWith(isAdmobReady: !isPro && _admobService.hasInitialized));
    }
  }

  void _startAppOpenAdLifecycle() {
    _lifecycleObserver.startObserving();

    _lifecycleSubscription?.cancel();
    _lifecycleSubscription = _lifecycleObserver.onLifecycleChange.listen((
      lifecycleState,
    ) {
      if (lifecycleState == AppLifecycleState.resumed &&
          _lifecycleObserver.canTriggerAdOnResume) {
        if (!isPro && state.shouldShowInterstitialAd != true) {
          _admobService.showAppOpenAd();
        }
      }
    });
    _admobService.preloadAppOpenAd(showAfterLoad: false);
    _admobService.preloadInterstitialAd();
  }

  /// Track install/open event with FCM token
  Future<void> _trackInstallAndUpdateToken() async {
    await _fcmService.init();

    // Get current token and send install event for first time open app
    final token = await _fcmService.getToken();
    log('Fcm Token: $token');
    await _appTrackingRepository.sendInstallEvent(fcmToken: token);

    // Update token if it is changed
    _fcmTokenSubscription?.cancel();
    _fcmTokenSubscription = _fcmService.onTokenRefresh.listen((token) {
      _appTrackingRepository.sendInstallEvent(fcmToken: token);
    });
  }

  Future<void> _loadFullscreenAdFrequency() async {
    final result = await _adRepository.getFullscreenAdFrequency();
    switch (result) {
      case Success(data: final frequency):
        _admobService.fullscreenAdRandomness = frequency;
      case Error():
        break;
    }
  }

  @override
  Future<void> close() async {
    await _premiumSubscription?.cancel();
    _premiumSubscription = null;
    await _lifecycleSubscription?.cancel();
    _lifecycleSubscription = null;
    await _fcmTokenSubscription?.cancel();
    _fcmTokenSubscription = null;
    _lifecycleObserver.dispose();
    return super.close();
  }
}
