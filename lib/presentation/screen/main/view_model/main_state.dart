import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class MainState extends BaseState {
  final int currentTabIndex;

  const MainState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.currentTabIndex = 0,
  });

  @override
  MainState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    int? currentTabIndex,
  }) {
    return MainState(
      status: status ?? this.status,
      errorMessage:
          errorMessage != null ? errorMessage.value : this.errorMessage,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
    );
  }
}
