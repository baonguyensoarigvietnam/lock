import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_list_view.dart';
import 'package:applock/utility/enumeration/alerts_tab_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class AlertsState extends BaseState {
  final AlertsTabStep currentStep;
  final AlertsTabStep previousListStep;
  final List<AlertEventItem> items;
  final AlertEventItem selectedAlert;

  static const List<AlertEventItem> defaultAlerts = [
    AlertEventItem(
      title: 'Gallery',
      timeLabel: '14:22 PM',
      failedMethod: 'PIN',
      attemptedContext: 'Vault Access',
      detailedMethod: 'PIN Code',
      failedCount: 3,
      detailedDateTime: 'Oct 24, 02:14 AM',
      hasPhoto: true,
    ),
    AlertEventItem(
      title: 'Main Unlock',
      timeLabel: '09:15 AM',
      failedMethod: 'Pattern',
      attemptedContext: 'Main Unlock',
      detailedMethod: 'Pattern',
      failedCount: 3,
      detailedDateTime: 'Oct 24, 09:15 AM',
      hasPhoto: true,
    ),
    AlertEventItem(
      title: 'Vault Unlock',
      timeLabel: 'Yesterday',
      failedMethod: 'Pattern',
      attemptedContext: 'Vault Access',
      detailedMethod: 'Pattern',
      failedCount: 3,
      detailedDateTime: 'Oct 23, 08:40 PM',
      hasPhoto: true,
    ),
    AlertEventItem(
      title: 'Main Unlock',
      timeLabel: 'Aug 12',
      failedMethod: 'Pattern',
      attemptedContext: 'Main Unlock',
      detailedMethod: 'Pattern',
      failedCount: 3,
      detailedDateTime: 'Aug 12, 11:18 AM',
      hasPhoto: false,
    ),
  ];

  const AlertsState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.currentStep = AlertsTabStep.intruderSelfieOff,
    this.previousListStep = AlertsTabStep.alertsListFree,
    this.items = defaultAlerts,
    this.selectedAlert = const AlertEventItem(
      title: 'Gallery',
      timeLabel: '14:22 PM',
      failedMethod: 'PIN',
      attemptedContext: 'Vault Access',
      detailedMethod: 'PIN Code',
      failedCount: 3,
      detailedDateTime: 'Oct 24, 02:14 AM',
      hasPhoto: true,
    ),
  });

  @override
  AlertsState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    AlertsTabStep? currentStep,
    AlertsTabStep? previousListStep,
    List<AlertEventItem>? items,
    AlertEventItem? selectedAlert,
  }) {
    return AlertsState(
      status: status ?? this.status,
      errorMessage:
          errorMessage != null ? errorMessage.value : this.errorMessage,
      currentStep: currentStep ?? this.currentStep,
      previousListStep: previousListStep ?? this.previousListStep,
      items: items ?? this.items,
      selectedAlert: selectedAlert ?? this.selectedAlert,
    );
  }
}
