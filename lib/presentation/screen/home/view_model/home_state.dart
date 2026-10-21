import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/home_theme_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class HomeState extends BaseState {
  final int lockedCount;
  final bool isServiceActive;
  final bool isBiometricEnabled;
  final HomeThemeStep currentStep;

  const HomeState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.lockedCount = 5,
    this.isServiceActive = false,
    this.isBiometricEnabled = false,
    this.currentStep = HomeThemeStep.dashboard,
  });

  @override
  HomeState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    int? lockedCount,
    bool? isServiceActive,
    bool? isBiometricEnabled,
    HomeThemeStep? currentStep,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage:
          errorMessage != null ? errorMessage.value : this.errorMessage,
      lockedCount: lockedCount ?? this.lockedCount,
      isServiceActive: isServiceActive ?? this.isServiceActive,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      currentStep: currentStep ?? this.currentStep,
    );
  }
}
