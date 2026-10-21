import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/home_theme_step.dart';
import 'package:applock/utility/enumeration/lock_screen_theme.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class HomeState extends BaseState {
  final int lockedCount;
  final int vaultItemsCount;
  final int intruderAlertsCount;
  final bool isServiceActive;
  final bool isBiometricEnabled;
  final HomeThemeStep currentStep;
  final LockScreenTheme lockScreenTheme;

  const HomeState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.lockedCount = 0,
    this.vaultItemsCount = 0,
    this.intruderAlertsCount = 0,
    this.isServiceActive = false,
    this.isBiometricEnabled = false,
    this.currentStep = HomeThemeStep.dashboard,
    this.lockScreenTheme = LockScreenTheme.vault,
  });

  @override
  HomeState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    int? lockedCount,
    int? vaultItemsCount,
    int? intruderAlertsCount,
    bool? isServiceActive,
    bool? isBiometricEnabled,
    HomeThemeStep? currentStep,
    LockScreenTheme? lockScreenTheme,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage:
          errorMessage != null ? errorMessage.value : this.errorMessage,
      lockedCount: lockedCount ?? this.lockedCount,
      vaultItemsCount: vaultItemsCount ?? this.vaultItemsCount,
      intruderAlertsCount: intruderAlertsCount ?? this.intruderAlertsCount,
      isServiceActive: isServiceActive ?? this.isServiceActive,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      currentStep: currentStep ?? this.currentStep,
      lockScreenTheme: lockScreenTheme ?? this.lockScreenTheme,
    );
  }
}
