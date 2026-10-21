import 'package:injectable/injectable.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/permission_guide/view_model/permission_guide_state.dart';
import 'package:applock/service/app_lock/app_lock_service.dart';
import 'package:applock/service/permission/permission_service.dart';

@injectable
class PermissionGuideViewModel extends BaseCubit<PermissionGuideState> {
  final PermissionService _permissionService;
  final AppLockRepository _repository;
  final AppLockService _appLockService;

  PermissionGuideViewModel(
    this._permissionService,
    this._repository,
    this._appLockService,
  ) : super(const PermissionGuideState());

  Future<void> checkPermissions() async {
    final usage = await _permissionService.isUsageAccessGranted();
    final overlay = await _permissionService.isOverlayPermissionGranted();
    final notification =
        await _permissionService.isNotificationPermissionGranted();
    final photos = await _permissionService.isPhotosPermissionGranted();
    final camera = await _permissionService.isCameraPermissionGranted();

    emit(state.copyWith(
      isUsageAccessGranted: usage,
      isOverlayGranted: overlay,
      isNotificationGranted: notification,
      isPhotosGranted: photos,
      isCameraGranted: camera,
    ));
  }

  Future<void> requestUsageAccess() async {
    await _permissionService.requestUsageAccess();
    await checkPermissions();
  }

  Future<void> requestOverlay() async {
    await _permissionService.requestOverlayPermission();
    await checkPermissions();
  }

  Future<void> requestNotification() async {
    await _permissionService.requestNotificationPermission();
    await checkPermissions();
  }

  Future<void> requestPhotos() async {
    await _permissionService.requestPhotosPermission();
    await checkPermissions();
  }

  Future<void> requestCamera() async {
    await _permissionService.requestCameraPermission();
    await checkPermissions();
  }

  Future<void> continueFlow() async {
    await _appLockService.startService();
    await _repository.setServiceActive(true);
    await _repository.setOnboardingCompleted(true);
    emit(state.copyWith(isCompleted: true));
  }
}
