import 'package:injectable/injectable.dart';
import 'package:applock/domain/model/app_lock_item.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/apps/view_model/apps_state.dart';
import 'package:applock/service/permission/permission_service.dart';
import 'package:applock/utility/enumeration/apps_filter_tab.dart';
import 'package:applock/utility/enumeration/apps_tab_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';
import 'package:applock/utility/helper/result.dart';

@injectable
class AppsViewModel extends BaseCubit<AppsState> {
  final AppLockRepository _repository;
  final PermissionService _permissionService;

  AppsViewModel(
    this._repository,
    this._permissionService,
  ) : super(const AppsState());

  Future<void> init() async {
    emit(state.copyWith(status: ViewStatus.loading));
    await fetchInstalledApps();
  }

  Future<void> fetchInstalledApps() async {
    final result = await _repository.getInstalledApps();
    if (result is Success<List<AppLockItem>>) {
      final apps = result.data;
      emit(state.copyWith(
        status: ViewStatus.success,
        apps: apps,
        filteredApps: _applyFilter(
          apps,
          state.searchQuery,
          state.onlyLockedFilter,
          state.selectedCategory,
        ),
      ));
    } else {
      emitError('Không thể tải danh sách ứng dụng');
    }
  }

  Future<void> toggleLock(String packageName) async {
    final index = state.apps.indexWhere((a) => a.packageName == packageName);
    if (index == -1) return;

    final target = state.apps[index];
    final newLocked = !target.isLocked;

    final updatedList = List<AppLockItem>.from(state.apps);
    updatedList[index] = target.copyWith(isLocked: newLocked);

    emit(state.copyWith(
      apps: updatedList,
      filteredApps: _applyFilter(
        updatedList,
        state.searchQuery,
        state.onlyLockedFilter,
        state.selectedCategory,
      ),
    ));

    await _repository.toggleLockApp(packageName, newLocked);
  }

  void search(String query) {
    emit(state.copyWith(
      searchQuery: query,
      filteredApps: _applyFilter(
        state.apps,
        query,
        state.onlyLockedFilter,
        state.selectedCategory,
      ),
    ));
  }

  void setAppsFilterTab(AppsFilterTab tab) {
    final onlyLocked = tab == AppsFilterTab.locked;
    emit(state.copyWith(
      appsFilterTab: tab,
      onlyLockedFilter: onlyLocked,
      selectedCategory: const Nullable(null),
      filteredApps: _applyFilter(
        state.apps,
        state.searchQuery,
        onlyLocked,
        null,
      ),
    ));
  }

  void selectCategory(String? category) {
    emit(state.copyWith(
      appsFilterTab: AppsFilterTab.all,
      onlyLockedFilter: false,
      selectedCategory: Nullable(category),
      filteredApps: _applyFilter(
        state.apps,
        state.searchQuery,
        false,
        category,
      ),
    ));
  }

  Future<void> enableUsageAccessFromAppsTab() async {
    emit(state.copyWith(appsTabStep: AppsTabStep.limitedProtectionWarning));
  }

  Future<void> fixLimitedPermissions() async {
    await _permissionService.requestOverlayPermission();
    await _permissionService.requestIgnoreBatteryOptimization();
    emit(state.copyWith(appsTabStep: AppsTabStep.appList));
  }

  void continueWithLimitedProtection() {
    emit(state.copyWith(appsTabStep: AppsTabStep.appList));
  }

  List<AppLockItem> _applyFilter(
    List<AppLockItem> list,
    String query,
    bool onlyLocked, [
    String? category,
  ]) {
    return list.where((app) {
      final matchesQuery = query.isEmpty ||
          app.appName.toLowerCase().contains(query.toLowerCase()) ||
          app.packageName.toLowerCase().contains(query.toLowerCase()) ||
          app.category.toLowerCase().contains(query.toLowerCase());
      final matchesLocked = !onlyLocked || app.isLocked;
      final matchesCategory = category == null ||
          app.category.toLowerCase() == category.toLowerCase() ||
          (category == 'Messaging' && app.category == 'Communication') ||
          (category == 'Photos & Video' && app.category == 'Media');
      return matchesQuery && matchesLocked && matchesCategory;
    }).toList();
  }
}
