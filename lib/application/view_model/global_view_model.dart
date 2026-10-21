import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:applock/application/view_model/global_view_model_state.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/service/permission/permission_service.dart';

@lazySingleton
class GlobalViewModel extends BaseCubit<GlobalViewModelState> {
  final AppLockRepository _repository;
  final PermissionService _permissionService;

  GlobalViewModel(this._repository, this._permissionService)
      : super(const GlobalViewModelState());

  Future<void> init() async {
    final configResult = await _repository.getLockConfig();
    final isOverlay = await _permissionService.isOverlayPermissionGranted();

    configResult.when(
      success: (config) {
        emit(state.copyWith(
          lockConfig: config,
          isOverlayGranted: isOverlay,
        ));
      },
      error: (_) {
        emit(state.copyWith(isOverlayGranted: isOverlay));
      },
    );
  }

  void setLocale(Locale locale) {
    emit(state.copyWith(locale: locale));
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
