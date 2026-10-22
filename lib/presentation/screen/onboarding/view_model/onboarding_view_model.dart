import 'package:injectable/injectable.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/onboarding/view_model/onboarding_state.dart';
import 'package:applock/service/permission/permission_service.dart';
import 'package:applock/utility/enumeration/view_status.dart';

@injectable
class OnboardingViewModel extends BaseCubit<OnboardingState> {
  final AppLockRepository _repository;
  final PermissionService _permissionService;

  OnboardingViewModel(
    this._repository,
    this._permissionService,
  ) : super(const OnboardingState());

  void setPage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  Future<void> requestAllPermissions() async {
    await _permissionService.requestAllPermissions();
  }

  Future<void> completeOnboarding() async {
    emit(state.copyWith(status: ViewStatus.loading));
    await _repository.setOnboardingCompleted(true);
    emit(state.copyWith(
      status: ViewStatus.success,
      isCompleted: true,
    ));
  }
}
