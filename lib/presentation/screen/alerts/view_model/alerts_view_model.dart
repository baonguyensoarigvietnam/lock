import 'package:injectable/injectable.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/alerts/view_model/alerts_state.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_list_view.dart';
import 'package:applock/utility/enumeration/alerts_tab_step.dart';

@injectable
class AlertsViewModel extends BaseCubit<AlertsState> {
  AlertsViewModel() : super(const AlertsState());

  void setStep(AlertsTabStep step) {
    emit(state.copyWith(currentStep: step));
  }

  void openAlertDetail(AlertEventItem item, AlertsTabStep fromStep) {
    emit(state.copyWith(
      selectedAlert: item,
      previousListStep: fromStep,
      currentStep: AlertsTabStep.alertDetail,
    ));
  }

  void returnToList() {
    emit(state.copyWith(currentStep: state.previousListStep));
  }
}
