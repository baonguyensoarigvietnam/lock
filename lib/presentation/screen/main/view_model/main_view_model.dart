import 'package:injectable/injectable.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/main/view_model/main_state.dart';

@injectable
class MainViewModel extends BaseCubit<MainState> {
  MainViewModel() : super(const MainState());

  void setTab(int index) {
    if (state.currentTabIndex == index) return;
    emit(state.copyWith(currentTabIndex: index));
  }
}
