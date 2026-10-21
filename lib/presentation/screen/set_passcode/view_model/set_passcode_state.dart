import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

enum SetPasscodeStep { enterNew, confirm }

class SetPasscodeState extends BaseState {
  final SetPasscodeStep step;
  final String firstPin;
  final String currentInput;
  final String? validationError;
  final bool isCompleted;

  const SetPasscodeState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.step = SetPasscodeStep.enterNew,
    this.firstPin = '',
    this.currentInput = '',
    this.validationError,
    this.isCompleted = false,
  });

  @override
  SetPasscodeState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    SetPasscodeStep? step,
    String? firstPin,
    String? currentInput,
    Nullable<String>? validationError,
    bool? isCompleted,
  }) {
    return SetPasscodeState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
      step: step ?? this.step,
      firstPin: firstPin ?? this.firstPin,
      currentInput: currentInput ?? this.currentInput,
      validationError: validationError != null
          ? validationError.value
          : this.validationError,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
