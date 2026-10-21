import 'package:flutter/material.dart';
import 'package:applock/domain/model/lock_config.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class GlobalViewModelState extends BaseState {
  final Locale locale;
  final LockConfig lockConfig;
  final bool isOverlayGranted;

  const GlobalViewModelState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.locale = const Locale('en'),
    this.lockConfig = const LockConfig(),
    this.isOverlayGranted = false,
  });

  @override
  GlobalViewModelState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    Locale? locale,
    LockConfig? lockConfig,
    bool? isOverlayGranted,
  }) {
    return GlobalViewModelState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
      locale: locale ?? this.locale,
      lockConfig: lockConfig ?? this.lockConfig,
      isOverlayGranted: isOverlayGranted ?? this.isOverlayGranted,
    );
  }
}
