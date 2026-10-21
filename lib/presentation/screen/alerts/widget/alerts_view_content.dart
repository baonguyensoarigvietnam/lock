import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/screen/alerts/alerts_navigator.dart';
import 'package:applock/presentation/screen/alerts/view_model/alerts_state.dart';
import 'package:applock/presentation/screen/alerts/view_model/alerts_view_model.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_camera_denied_view.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_detail_view.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_intruder_off_view.dart';
import 'package:applock/presentation/screen/alerts/widget/alerts_list_view.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/utility/enumeration/alerts_tab_step.dart';
import 'package:applock/utility/extension/build_context.dart';

class AlertsViewContent extends StatefulWidget {
  const AlertsViewContent({super.key});

  @override
  State<AlertsViewContent> createState() => _AlertsViewContentState();
}

class _AlertsViewContentState extends State<AlertsViewContent>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<AlertsViewModel>().loadData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Refresh permission status / new alerts when returning from settings
    // or after the lock screen recorded a new intrusion.
    if (state == AppLifecycleState.resumed) {
      context.read<AlertsViewModel>().loadData(showLoading: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPalette.white,
      body: SafeArea(
        child: BlocBuilder<AlertsViewModel, AlertsState>(
          builder: (context, state) {
            if (state.isInitial || (state.isLoading && state.alerts.isEmpty)) {
              return const Center(child: CircularProgressIndicator());
            }
            return _buildStepContent(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildStepContent(BuildContext context, AlertsState state) {
    final vm = context.read<AlertsViewModel>();
    final navigator = context.read<AlertsNavigator>();

    switch (state.currentStep) {
      case AlertsTabStep.intruderSelfieOff:
        return AlertsIntruderOffView(
          onEnableTap: vm.enableIntruderCapture,
        );
      case AlertsTabStep.cameraPermissionDenied:
        return AlertsCameraDeniedView(
          isPermanentlyDenied: state.isCameraPermanentlyDenied,
          onOpenSettingsTap: vm.requestCameraPermission,
        );
      case AlertsTabStep.alertsList:
        return AlertsListView(
          alerts: state.alerts,
          todayFailedCount: state.todayFailedCount,
          onUpgradeTap: navigator.goToPaywall,
          onSelectAlert: vm.openAlertDetail,
          onRefresh: () => vm.loadData(showLoading: false),
        );
      case AlertsTabStep.alertDetail:
        final alert = state.selectedAlert;
        if (alert == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) vm.returnToList();
          },
          child: AlertsDetailView(
            item: alert,
            isCameraGranted: state.isCameraGranted,
            onBack: vm.returnToList,
            onDeleteConfirmed: () => _deleteAlert(context),
            onSaveEvidence: () => _saveEvidence(context),
            onEnableCameraPermission: vm.requestCameraPermission,
          ),
        );
    }
  }

  Future<void> _saveEvidence(BuildContext context) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final path = await context.read<AlertsViewModel>().saveSelectedEvidence();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            path != null
                ? l10n.intruderEvidenceSavedTo(path)
                : l10n.intruderEvidenceSaveFailed,
          ),
          duration: const Duration(seconds: 3),
        ),
      );
  }

  Future<void> _deleteAlert(BuildContext context) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final success = await context.read<AlertsViewModel>().deleteSelectedAlert();
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            success ? l10n.intruderAlertDeleted : l10n.intruderDeleteFailed,
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }
}
