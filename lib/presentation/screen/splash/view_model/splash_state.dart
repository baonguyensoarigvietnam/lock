import 'package:applock/domain/model/lock_screen_args.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

/// Where the splash screen should send the user.
enum SplashDestination { onboarding, setPasscode, lockScreen }

class SplashState extends BaseState {
  final SplashDestination? destination;
  final LockScreenArgs? lockArgs;

  const SplashState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.destination,
    this.lockArgs,
  });

  @override
  SplashState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    SplashDestination? destination,
    LockScreenArgs? lockArgs,
  }) {
    return SplashState(
      status: status ?? this.status,
      errorMessage:
          errorMessage != null ? errorMessage.value : this.errorMessage,
      destination: destination ?? this.destination,
      lockArgs: lockArgs ?? this.lockArgs,
    );
  }
}
