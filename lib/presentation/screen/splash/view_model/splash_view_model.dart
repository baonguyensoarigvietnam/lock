import 'package:injectable/injectable.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/splash/view_model/splash_state.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/result.dart';

@injectable
class SplashViewModel extends BaseCubit<SplashState> {
  final AppLockRepository _repository;

  SplashViewModel(this._repository) : super(const SplashState());

  Future<void> checkInitialRoute() async {
    emit(state.copyWith(status: ViewStatus.loading));
    // Brief splash duration for smooth animation
    await Future.delayed(const Duration(milliseconds: 1800));

    final onboardingRes = await _repository.isOnboardingCompleted();
    final configRes = await _repository.getLockConfig();

    bool isOnboarded = false;
    if (onboardingRes is Success<bool>) {
      isOnboarded = onboardingRes.data;
    }

    bool hasPin = false;
    if (configRes is Success) {
      hasPin = (configRes as Success).data.hasPinCode;
    }

    emit(state.copyWith(
      status: ViewStatus.success,
      isOnboardingCompleted: isOnboarded,
      hasPin: hasPin,
    ));
  }
}
