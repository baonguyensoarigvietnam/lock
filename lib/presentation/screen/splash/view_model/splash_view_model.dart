import 'package:injectable/injectable.dart';
import 'package:applock/domain/model/lock_config.dart';
import 'package:applock/domain/model/lock_screen_args.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/splash/view_model/splash_state.dart';
import 'package:applock/service/app_lock/app_lock_service.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/result.dart';

@injectable
class SplashViewModel extends BaseCubit<SplashState> {
  final AppLockRepository _repository;
  final AppLockService _appLockService;

  SplashViewModel(this._repository, this._appLockService)
      : super(const SplashState());

  Future<void> checkInitialRoute() async {
    emit(state.copyWith(status: ViewStatus.loading));

    // Opened by the native service because a protected app was launched:
    // skip the animation and lock immediately.
    final pendingLock = await _appLockService.consumePendingLock();
    if (pendingLock != null) {
      _emitDestination(SplashDestination.lockScreen, pendingLock);
      return;
    }

    // Brief splash duration for smooth animation
    await Future.delayed(const Duration(milliseconds: 1800));

    final onboardingRes = await _repository.isOnboardingCompleted();
    final configRes = await _repository.getLockConfig();

    final isOnboarded = onboardingRes is Success<bool> && onboardingRes.data;
    final config = configRes is Success<LockConfig> ? configRes.data : null;
    final hasSecret =
        config != null && (config.hasPinCode || config.hasPattern);

    if (!isOnboarded) {
      _emitDestination(SplashDestination.onboarding);
    } else if (hasSecret) {
      _emitDestination(
        SplashDestination.lockScreen,
        const LockScreenArgs(mode: LockScreenMode.selfUnlock),
      );
    } else {
      _emitDestination(SplashDestination.setPasscode);
    }
  }

  void _emitDestination(SplashDestination destination, [LockScreenArgs? args]) {
    if (isClosed) return;
    emit(state.copyWith(
      status: ViewStatus.success,
      destination: destination,
      lockArgs: args,
    ));
  }
}
