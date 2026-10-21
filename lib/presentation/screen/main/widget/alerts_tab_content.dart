import 'package:flutter/material.dart';
import 'package:applock/presentation/screen/main/widget/alerts_camera_denied_view.dart';
import 'package:applock/presentation/screen/main/widget/alerts_detail_view.dart';
import 'package:applock/presentation/screen/main/widget/alerts_intruder_off_view.dart';
import 'package:applock/presentation/screen/main/widget/alerts_list_view.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/utility/enumeration/alerts_tab_step.dart';

class AlertsTabContent extends StatefulWidget {
  const AlertsTabContent({super.key});

  @override
  State<AlertsTabContent> createState() => _AlertsTabContentState();
}

class _AlertsTabContentState extends State<AlertsTabContent> {
  AlertsTabStep _currentStep = AlertsTabStep.intruderSelfieOff;
  AlertsTabStep _previousListStep = AlertsTabStep.alertsListFree;

  static const List<AlertEventItem> _defaultAlerts = [
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

  late AlertEventItem _selectedAlert = _defaultAlerts.first;

  void _openAlertDetail(AlertEventItem item, AlertsTabStep fromStep) {
    setState(() {
      _selectedAlert = item;
      _previousListStep = fromStep;
      _currentStep = AlertsTabStep.alertDetail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPalette.white,
      body: SafeArea(
        child: _buildStepContent(),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case AlertsTabStep.intruderSelfieOff:
        return AlertsIntruderOffView(
          onEnableTap: () {
            setState(() {
              _currentStep = AlertsTabStep.cameraPermissionDenied;
            });
          },
        );
      case AlertsTabStep.cameraPermissionDenied:
        return AlertsCameraDeniedView(
          onOpenSettingsTap: () {
            setState(() {
              _currentStep = AlertsTabStep.alertsListFree;
            });
          },
        );
      case AlertsTabStep.alertsListFree:
        return AlertsListView(
          isPremium: false,
          items: _defaultAlerts,
          onToggleMode: () {
            setState(() {
              _currentStep = AlertsTabStep.alertsListPremium;
            });
          },
          onUpgradeTap: () {
            setState(() {
              _currentStep = AlertsTabStep.alertsListPremium;
            });
          },
          onSelectAlert: (item) =>
              _openAlertDetail(item, AlertsTabStep.alertsListFree),
        );
      case AlertsTabStep.alertsListPremium:
        return AlertsListView(
          isPremium: true,
          items: _defaultAlerts,
          onToggleMode: () {
            setState(() {
              _currentStep = AlertsTabStep.alertsListFree;
            });
          },
          onUpgradeTap: () {},
          onSelectAlert: (item) =>
              _openAlertDetail(item, AlertsTabStep.alertsListPremium),
        );
      case AlertsTabStep.alertDetail:
        return AlertsDetailView(
          item: _selectedAlert,
          onBack: () {
            setState(() {
              _currentStep = _previousListStep;
            });
          },
          onDeleteConfirmed: () {
            setState(() {
              _currentStep = _previousListStep;
            });
          },
        );
    }
  }
}
