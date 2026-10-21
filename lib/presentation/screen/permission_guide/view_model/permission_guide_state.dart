import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class PermissionGuideState extends BaseState {
  final bool isUsageAccessGranted;
  final bool isOverlayGranted;
  final bool isNotificationGranted;
  final bool isPhotosGranted;
  final bool isCameraGranted;
  final bool isCompleted;

  const PermissionGuideState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.isUsageAccessGranted = false,
    this.isOverlayGranted = false,
    this.isNotificationGranted = false,
    this.isPhotosGranted = false,
    this.isCameraGranted = false,
    this.isCompleted = false,
  });

  bool get areRequiredGranted => isUsageAccessGranted || isOverlayGranted;

  @override
  PermissionGuideState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    bool? isUsageAccessGranted,
    bool? isOverlayGranted,
    bool? isNotificationGranted,
    bool? isPhotosGranted,
    bool? isCameraGranted,
    bool? isCompleted,
  }) {
    return PermissionGuideState(
      status: status ?? this.status,
      errorMessage:
          errorMessage != null ? errorMessage.value : this.errorMessage,
      isUsageAccessGranted:
          isUsageAccessGranted ?? this.isUsageAccessGranted,
      isOverlayGranted: isOverlayGranted ?? this.isOverlayGranted,
      isNotificationGranted:
          isNotificationGranted ?? this.isNotificationGranted,
      isPhotosGranted: isPhotosGranted ?? this.isPhotosGranted,
      isCameraGranted: isCameraGranted ?? this.isCameraGranted,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
