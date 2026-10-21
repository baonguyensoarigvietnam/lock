import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class LockScreenState extends BaseState {
  final String currentInput;
  final String? targetAppName;
  final bool isBiometricAvailable;
  final bool isUnlocked;
  final bool hasErrorShake;

  const LockScreenState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.currentInput = '',
    this.targetAppName = 'Facebook',
    this.isBiometricAvailable = false,
    this.isUnlocked = false,
    this.hasErrorShake = false,
  });

  @override
  LockScreenState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    String? currentInput,
    String? targetAppName,
    bool? isBiometricAvailable,
    bool? isUnlocked,
    bool? hasErrorShake,
  }) {
    return LockScreenState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
      currentInput: currentInput ?? this.currentInput,
      targetAppName: targetAppName ?? this.targetAppName,
      isBiometricAvailable: isBiometricAvailable ?? this.isBiometricAvailable,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      hasErrorShake: hasErrorShake ?? this.hasErrorShake,
    );
  }
}
