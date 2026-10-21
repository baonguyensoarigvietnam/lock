import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class OnboardingState extends BaseState {
  final int currentPage;
  final bool isCompleted;

  const OnboardingState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.currentPage = 0,
    this.isCompleted = false,
  });

  @override
  OnboardingState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    int? currentPage,
    bool? isCompleted,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
