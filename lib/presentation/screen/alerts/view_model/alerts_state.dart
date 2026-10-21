import 'package:applock/domain/model/intruder_alert.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/alerts_tab_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class AlertsState extends BaseState {
  final AlertsTabStep currentStep;
  final List<IntruderAlert> alerts;
  final IntruderAlert? selectedAlert;
  final int todayFailedCount;
  final bool isCaptureEnabled;
  final bool isCameraGranted;
  final bool isCameraPermanentlyDenied;

  const AlertsState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.currentStep = AlertsTabStep.alertsList,
    this.alerts = const [],
    this.selectedAlert,
    this.todayFailedCount = 0,
    this.isCaptureEnabled = true,
    this.isCameraGranted = false,
    this.isCameraPermanentlyDenied = false,
  });

  @override
  AlertsState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    AlertsTabStep? currentStep,
    List<IntruderAlert>? alerts,
    Nullable<IntruderAlert>? selectedAlert,
    int? todayFailedCount,
    bool? isCaptureEnabled,
    bool? isCameraGranted,
    bool? isCameraPermanentlyDenied,
  }) {
    return AlertsState(
      status: status ?? this.status,
      errorMessage:
          errorMessage != null ? errorMessage.value : this.errorMessage,
      currentStep: currentStep ?? this.currentStep,
      alerts: alerts ?? this.alerts,
      selectedAlert:
          selectedAlert != null ? selectedAlert.value : this.selectedAlert,
      todayFailedCount: todayFailedCount ?? this.todayFailedCount,
      isCaptureEnabled: isCaptureEnabled ?? this.isCaptureEnabled,
      isCameraGranted: isCameraGranted ?? this.isCameraGranted,
      isCameraPermanentlyDenied:
          isCameraPermanentlyDenied ?? this.isCameraPermanentlyDenied,
    );
  }
}
