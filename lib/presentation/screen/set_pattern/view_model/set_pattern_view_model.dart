import 'package:injectable/injectable.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/set_pattern/view_model/set_pattern_state.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

@injectable
class SetPatternViewModel extends BaseCubit<SetPatternState> {
  final AppLockRepository _repository;

  SetPatternViewModel(this._repository) : super(const SetPatternState());

  /// Called when the user finishes drawing on the grid.
  Future<void> onPatternComplete(List<int> pattern) async {
    if (pattern.length < SetPatternState.minDots) return;

    emit(state.copyWith(
      currentPattern: pattern,
      validationError: const Nullable(null),
    ));

    await _processPattern(pattern);
  }

  /// Reset the current drawing attempt (e.g. while still on same step).
  void resetCurrentPattern() {
    emit(state.copyWith(
      currentPattern: [],
      validationError: const Nullable(null),
    ));
  }

  void handleBack() {
    if (state.step == SetPatternStep.confirm) {
      emit(state.copyWith(
        step: SetPatternStep.enterNew,
        currentPattern: [],
        firstPattern: [],
        validationError: const Nullable(null),
      ));
    }
  }

  Future<void> _processPattern(List<int> pattern) async {
    if (state.step == SetPatternStep.enterNew) {
      await Future.delayed(const Duration(milliseconds: 200));
      emit(state.copyWith(
        step: SetPatternStep.confirm,
        firstPattern: pattern,
        currentPattern: [],
        validationError: const Nullable(null),
      ));
    } else {
      // Confirm step
      if (_patternsMatch(pattern, state.firstPattern)) {
        emit(state.copyWith(status: ViewStatus.loading));
        final patternString = pattern.join(',');
        await _repository.savePattern(patternString);
        emit(state.copyWith(
          status: ViewStatus.success,
          isCompleted: true,
        ));
      } else {
        await Future.delayed(const Duration(milliseconds: 200));
        emit(state.copyWith(
          currentPattern: [],
          validationError: const Nullable('mismatch'),
        ));
      }
    }
  }

  bool _patternsMatch(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
