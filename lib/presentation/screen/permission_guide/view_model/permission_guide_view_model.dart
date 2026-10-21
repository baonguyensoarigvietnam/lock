import 'package:injectable/injectable.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/permission_guide/view_model/permission_guide_state.dart';
import 'package:applock/service/app_lock/lock_engine_coordinator.dart';
import 'package:applock/service/permission/permission_service.dart';

@injectable
class PermissionGuideViewModel extends BaseCubit<PermissionGuideState> {
  final PermissionService _permissionService;
  final AppLockRepository _repository;
  final LockEngineCoordinator _lockEngineCoordinator;

  PermissionGuideViewModel(
    this._permissionService,
    this._repository,
    this._lockEngineCoordinator,
  ) : super(const PermissionGuideState());

  Future<void> checkPermissions() async {
    final usage = await _permissionService.isUsageAccessGranted();
    final overlay = await _permissionService.isOverlayPermissionGranted();
    final notification =
        await _permissionService.isNotificationPermissionGranted();
    final battery = await _permissionService.isBatteryOptimizationIgnored();
    final camera = await _permissionService.isCameraPermissionGranted();

    if (isClosed) return;
    emit(state.copyWith(
      isUsageAccessGranted: usage,
      isOverlayGranted: overlay,
      isNotificationGranted: notification,
      isBatteryOptimizationIgnored: battery,
      isCameraGranted: camera,
    ));
  }

  /// Opens the Usage Access settings page; the state is refreshed on resume.
  Future<void> requestUsageAccess() async {
    await _permissionService.requestUsageAccess();
  }

  /// Opens the overlay settings page; the state is refreshed on resume.
  Future<void> requestOverlay() async {
    await _permissionService.requestOverlayPermission();
  }

  Future<void> requestNotification() async {
    await _permissionService.requestNotificationPermission();
    await checkPermissions();
  }

  /// Opens the battery optimization settings; refreshed on resume.
  Future<void> requestBatteryOptimization() async {
    await _permissionService.requestIgnoreBatteryOptimization();
  }

  Future<void> requestCamera() async {
    if (await _permissionService.isCameraPermissionPermanentlyDenied()) {
      await _permissionService.openAppSettingsPage();
      return;
    }
    await _permissionService.requestCameraPermission();
    await checkPermissions();
  }

  /// Finishes onboarding and starts the lock engine.
  /// Returns `false` when protection could not start (Usage Access missing).
  Future<bool> continueFlow() async {
    await _repository.setServiceActive(true);
    await _repository.setOnboardingCompleted(true);
    await _lockEngineCoordinator.syncAll();
    final usage = await _permissionService.isUsageAccessGranted();
    if (isClosed) return usage;
    emit(state.copyWith(isCompleted: true));
    return usage;
  }
}
