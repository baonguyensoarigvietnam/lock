import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class SplashState extends BaseState {
  final bool hasPin;
  final bool isOnboardingCompleted;

  const SplashState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.hasPin = false,
    this.isOnboardingCompleted = false,
  });

  @override
  SplashState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    bool? hasPin,
    bool? isOnboardingCompleted,
  }) {
    return SplashState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
      hasPin: hasPin ?? this.hasPin,
      isOnboardingCompleted: isOnboardingCompleted ?? this.isOnboardingCompleted,
    );
  }
}
