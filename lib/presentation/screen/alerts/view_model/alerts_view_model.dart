import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:applock/domain/model/intruder_alert.dart';
import 'package:applock/domain/repository/intruder_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/alerts/view_model/alerts_state.dart';
import 'package:applock/service/permission/permission_service.dart';
import 'package:applock/utility/enumeration/alerts_tab_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';
import 'package:applock/utility/helper/result.dart';

@injectable
class AlertsViewModel extends BaseCubit<AlertsState> {
  AlertsViewModel(this._repository, this._permissionService)
      : super(const AlertsState());

  final IntruderRepository _repository;
  final PermissionService _permissionService;

  /// Loads settings, permission status and alerts, then picks the right step.
  Future<void> loadData({bool showLoading = true}) async {
    if (showLoading) emitLoading();

    final enabledResult = await _repository.isIntruderCaptureEnabled();
    final isEnabled =
        enabledResult is Success<bool> ? enabledResult.data : true;
    final isGranted = await _permissionService.isCameraPermissionGranted();
    final isPermanentlyDenied =
        !isGranted && await Permission.camera.isPermanentlyDenied;

    final alertsResult = await _repository.getAlerts();
    final alerts = alertsResult is Success<List<IntruderAlert>>
        ? alertsResult.data
        : <IntruderAlert>[];
    final todayResult = await _repository.getTodayFailedCount();
    final todayCount = todayResult is Success<int> ? todayResult.data : 0;

    // Keep the detail view open if its alert still exists.
    final selected = state.selectedAlert;
    final stillSelected = selected == null
        ? null
        : alerts.where((a) => a.id == selected.id).firstOrNull;
    final keepDetail =
        state.currentStep == AlertsTabStep.alertDetail && stillSelected != null;

    emit(state.copyWith(
      status: alertsResult is Success ? ViewStatus.success : ViewStatus.failure,
      errorMessage: Nullable(
        alertsResult is Error<List<IntruderAlert>> ? alertsResult.message : null,
      ),
      alerts: alerts,
      todayFailedCount: todayCount,
      isCaptureEnabled: isEnabled,
      isCameraGranted: isGranted,
      isCameraPermanentlyDenied: isPermanentlyDenied,
      selectedAlert: Nullable(stillSelected),
      currentStep: keepDetail
          ? AlertsTabStep.alertDetail
          : _resolveListStep(isEnabled: isEnabled, isGranted: isGranted),
    ));
  }

  AlertsTabStep _resolveListStep({
    required bool isEnabled,
    required bool isGranted,
  }) {
    if (!isEnabled) return AlertsTabStep.intruderSelfieOff;
    if (!isGranted) return AlertsTabStep.cameraPermissionDenied;
    return AlertsTabStep.alertsList;
  }

  /// Turns intruder selfie on and asks for the camera permission.
  Future<void> enableIntruderCapture() async {
    await _repository.setIntruderCaptureEnabled(true);
    await requestCameraPermission();
  }

  /// Requests the camera permission, or opens the system settings when the
  /// permission has been permanently denied.
  /// Returns `true` when the permission is granted.
  Future<bool> requestCameraPermission() async {
    if (await _permissionService.isCameraPermissionGranted()) {
      await loadData(showLoading: false);
      return true;
    }
    if (await Permission.camera.isPermanentlyDenied) {
      await openAppSettings();
      // Status is refreshed when the app resumes (see AlertsViewContent).
      await loadData(showLoading: false);
      return false;
    }
    final granted = await _permissionService.requestCameraPermission();
    await loadData(showLoading: false);
    return granted;
  }

  void openAlertDetail(IntruderAlert alert) {
    emit(state.copyWith(
      selectedAlert: Nullable(alert),
      currentStep: AlertsTabStep.alertDetail,
    ));
  }

  void returnToList() {
    emit(state.copyWith(
      selectedAlert: const Nullable(null),
      currentStep: _resolveListStep(
        isEnabled: state.isCaptureEnabled,
        isGranted: state.isCameraGranted,
      ),
    ));
  }

  /// Deletes the currently selected alert. Returns `true` on success.
  Future<bool> deleteSelectedAlert() async {
    final alert = state.selectedAlert;
    if (alert == null) return false;
    final result = await _repository.deleteAlert(alert.id);
    if (result is Error) return false;
    returnToList();
    await loadData(showLoading: false);
    return true;
  }

  /// Copies the selected alert photo to the evidence folder.
  /// Returns the saved path, or `null` on failure.
  Future<String?> saveSelectedEvidence() async {
    final alert = state.selectedAlert;
    if (alert == null) return null;
    final result = await _repository.saveEvidence(alert);
    return result is Success<String> ? result.data : null;
  }
}
