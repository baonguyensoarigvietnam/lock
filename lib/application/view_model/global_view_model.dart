import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:applock/application/view_model/global_view_model_state.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/service/permission/permission_service.dart';
import 'package:applock/utility/enumeration/app_language.dart';
import 'package:applock/utility/helper/result.dart';

@lazySingleton
class GlobalViewModel extends BaseCubit<GlobalViewModelState> {
  final AppLockRepository _repository;
  final PermissionService _permissionService;

  GlobalViewModel(this._repository, this._permissionService)
      : super(const GlobalViewModelState());

  Future<void> init() async {
    final configResult = await _repository.getLockConfig();
    final langResult = await _repository.getLanguageCode();
    final isOverlay = await _permissionService.isOverlayPermissionGranted();

    var savedLocale = state.locale;
    if (langResult is Success<String>) {
      savedLocale = AppLanguage.fromCode(langResult.data).locale;
    }

    configResult.when(
      success: (config) {
        emit(state.copyWith(
          locale: savedLocale,
          lockConfig: config,
          isOverlayGranted: isOverlay,
        ));
      },
      error: (_) {
        emit(state.copyWith(
          locale: savedLocale,
          isOverlayGranted: isOverlay,
        ));
      },
    );
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
}

extension ResultExt<T> on Object {
  void when({
    required void Function(dynamic data) success,
    required void Function(dynamic error) error,
  }) {
    final res = this;
    if (res.runtimeType.toString().startsWith('Success')) {
      final dynamic d = (res as dynamic).data;
      success(d);
    } else {
      error(res);
    }
  }
}
