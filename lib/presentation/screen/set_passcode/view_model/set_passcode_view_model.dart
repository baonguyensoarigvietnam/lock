import 'package:injectable/injectable.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/set_passcode/view_model/set_passcode_state.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

@injectable
class SetPasscodeViewModel extends BaseCubit<SetPasscodeState> {
  final AppLockRepository _repository;

  static const int pinLength = 6;

  SetPasscodeViewModel(this._repository) : super(const SetPasscodeState());

  void appendDigit(String digit) {
    if (state.currentInput.length >= pinLength) return;
    final newInput = state.currentInput + digit;
    emit(state.copyWith(
      currentInput: newInput,
      validationError: const Nullable(null),
    ));

    if (newInput.length == pinLength) {
      _processInput(newInput);
    }
  }

  void deleteDigit() {
    if (state.currentInput.isEmpty) return;
    final newInput =
        state.currentInput.substring(0, state.currentInput.length - 1);
    emit(state.copyWith(
      currentInput: newInput,
      validationError: const Nullable(null),
    ));
  }

  void handleBack() {
    if (state.step == SetPasscodeStep.confirm) {
      emit(state.copyWith(
        step: SetPasscodeStep.enterNew,
        currentInput: '',
        firstPin: '',
        validationError: const Nullable(null),
      ));
    }
  }

  Future<void> _processInput(String input) async {
    if (state.step == SetPasscodeStep.enterNew) {
      await Future.delayed(const Duration(milliseconds: 180));
      emit(state.copyWith(
        step: SetPasscodeStep.confirm,
        firstPin: input,
        currentInput: '',
        validationError: const Nullable(null),
      ));
    } else {
      if (input == state.firstPin) {
        emit(state.copyWith(status: ViewStatus.loading));
        await _repository.savePinCode(input);
        emit(state.copyWith(
          status: ViewStatus.success,
          isCompleted: true,
        ));
      } else {
        await Future.delayed(const Duration(milliseconds: 150));
        emit(state.copyWith(
          currentInput: '',
          validationError: const Nullable('PIN does not match.'),
        ));
      }
    }
  }
}
