import 'package:injectable/injectable.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/unlock_method/view_model/unlock_method_state.dart';
import 'package:applock/utility/helper/nullable.dart';

@injectable
class UnlockMethodViewModel extends BaseCubit<UnlockMethodState> {
  UnlockMethodViewModel() : super(const UnlockMethodState());

  void selectMethod(UnlockMethodType type) {
    emit(state.copyWith(selectedMethod: Nullable(type)));
  }
}
