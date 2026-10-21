import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

enum UnlockMethodType { pin, pattern }

class UnlockMethodState extends BaseState {
  final UnlockMethodType? selectedMethod;

  const UnlockMethodState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.selectedMethod,
  });

  bool get canContinue => selectedMethod != null;

  @override
  UnlockMethodState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    Nullable<UnlockMethodType>? selectedMethod,
  }) {
    return UnlockMethodState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
      selectedMethod: selectedMethod != null
          ? selectedMethod.value
          : this.selectedMethod,
    );
  }
}
