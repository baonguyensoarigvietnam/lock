import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/screen/alerts/view_model/alerts_state.dart';
import 'package:applock/presentation/screen/alerts/view_model/alerts_view_model.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_camera_denied_view.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_detail_view.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_intruder_off_view.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_list_view.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/utility/enumeration/alerts_tab_step.dart';

class AlertsViewContent extends StatelessWidget {
  const AlertsViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPalette.white,
      body: SafeArea(
        child: BlocBuilder<AlertsViewModel, AlertsState>(
          builder: (context, state) {
            return _buildStepContent(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildStepContent(BuildContext context, AlertsState state) {
    final vm = context.read<AlertsViewModel>();

    switch (state.currentStep) {
      case AlertsTabStep.intruderSelfieOff:
        return AlertsIntruderOffView(
          onEnableTap: () => vm.setStep(AlertsTabStep.cameraPermissionDenied),
        );
      case AlertsTabStep.cameraPermissionDenied:
        return AlertsCameraDeniedView(
          onOpenSettingsTap: () => vm.setStep(AlertsTabStep.alertsListFree),
        );
      case AlertsTabStep.alertsListFree:
        return AlertsListView(
          isPremium: false,
          items: state.items,
          onToggleMode: () => vm.setStep(AlertsTabStep.alertsListPremium),
          onUpgradeTap: () => vm.setStep(AlertsTabStep.alertsListPremium),
          onSelectAlert: (item) =>
              vm.openAlertDetail(item, AlertsTabStep.alertsListFree),
        );
      case AlertsTabStep.alertsListPremium:
        return AlertsListView(
          isPremium: true,
          items: state.items,
          onToggleMode: () => vm.setStep(AlertsTabStep.alertsListFree),
          onUpgradeTap: () {},
          onSelectAlert: (item) =>
              vm.openAlertDetail(item, AlertsTabStep.alertsListPremium),
        );
      case AlertsTabStep.alertDetail:
        return AlertsDetailView(
          item: state.selectedAlert,
          onBack: () => vm.returnToList(),
          onDeleteConfirmed: () => vm.returnToList(),
        );
    }
  }
}
