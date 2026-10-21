import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

enum SetPatternStep { enterNew, confirm }

class SetPatternState extends BaseState {
  final SetPatternStep step;
  final List<int> firstPattern;
  final List<int> currentPattern;
  final String? validationError;
  final bool isCompleted;

  const SetPatternState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.step = SetPatternStep.enterNew,
    this.firstPattern = const [],
    this.currentPattern = const [],
    this.validationError,
    this.isCompleted = false,
  });

  static const int minDots = 4;

  @override
  SetPatternState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    SetPatternStep? step,
    List<int>? firstPattern,
    List<int>? currentPattern,
    Nullable<String>? validationError,
    bool? isCompleted,
  }) {
    return SetPatternState(
      status: status ?? this.status,
      errorMessage:
          errorMessage != null ? errorMessage.value : this.errorMessage,
      step: step ?? this.step,
      firstPattern: firstPattern ?? this.firstPattern,
      currentPattern: currentPattern ?? this.currentPattern,
      validationError: validationError != null
          ? validationError.value
          : this.validationError,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
