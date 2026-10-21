import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:applock/application/view_model/global_view_model_state.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/service/permission/permission_service.dart';
import 'package:applock/service/purchase/purchase_service.dart';
import 'package:applock/utility/enumeration/app_language.dart';
import 'package:applock/utility/helper/result.dart';

@lazySingleton
class GlobalViewModel extends BaseCubit<GlobalViewModelState> {
  final AppLockRepository _repository;
  final PermissionService _permissionService;
  final PurchaseService _purchaseService;

  StreamSubscription<bool>? _premiumSubscription;

  GlobalViewModel(
    this._repository,
    this._permissionService,
    this._purchaseService,
  ) : super(const GlobalViewModelState());

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
    emit(state.copyWith(isPremium: isPremium));
  }

  void _initPremium() {
    _purchaseService.initialize();
    emit(state.copyWith(isPremium: _purchaseService.isPremium));
    _premiumSubscription ??= _purchaseService.premiumStream.listen((value) {
      if (isClosed) return;
      emit(state.copyWith(isPremium: value));
    });
    unawaited(refreshPremium());
  }

  @override
  Future<void> close() async {
    await _premiumSubscription?.cancel();
    _premiumSubscription = null;
    return super.close();
  }
}
