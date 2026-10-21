import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class EnableBiometricState extends BaseState {
  final bool isBiometricSupported;
  final bool isBiometricEnabled;
  final bool isCompleted;

  const EnableBiometricState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.isBiometricSupported = true,
    this.isBiometricEnabled = false,
    this.isCompleted = false,
  });

  @override
  EnableBiometricState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    bool? isBiometricSupported,
    bool? isBiometricEnabled,
    bool? isCompleted,
  }) {
    return EnableBiometricState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
      isBiometricSupported: isBiometricSupported ?? this.isBiometricSupported,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
