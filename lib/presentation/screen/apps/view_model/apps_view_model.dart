import 'package:injectable/injectable.dart';
import 'package:applock/domain/model/app_lock_item.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/apps/view_model/apps_state.dart';
import 'package:applock/service/app_lock/lock_engine_coordinator.dart';
import 'package:applock/service/permission/permission_service.dart';
import 'package:applock/utility/enumeration/app_category.dart';
import 'package:applock/utility/enumeration/apps_filter_tab.dart';
import 'package:applock/utility/enumeration/apps_tab_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';
import 'package:applock/utility/helper/result.dart';

@injectable
class AppsViewModel extends BaseCubit<AppsState> {
  final AppLockRepository _repository;
  final PermissionService _permissionService;
  final LockEngineCoordinator _lockEngineCoordinator;

  /// The user chose "continue with limited protection" in this session.
  bool _limitedWarningDismissed = false;

  AppsViewModel(
    this._repository,
    this._permissionService,
    this._lockEngineCoordinator,
  ) : super(const AppsState());

  Future<void> init() async {
    emit(state.copyWith(status: ViewStatus.loading));
    await refreshPermissions();
    await fetchInstalledApps();
  }

  /// Re-checks the permissions the lock engine depends on and picks the step.
  Future<void> refreshPermissions() async {
    final usage = await _permissionService.isUsageAccessGranted();
    final overlay = await _permissionService.isOverlayPermissionGranted();
    final battery = await _permissionService.isBatteryOptimizationIgnored();

    final AppsTabStep step;
    if (!usage) {
      step = AppsTabStep.usageAccessRequired;
    } else if ((!overlay || !battery) && !_limitedWarningDismissed) {
      step = AppsTabStep.limitedProtectionWarning;
    } else {
      step = AppsTabStep.appList;
    }

    if (isClosed) return;
    emit(state.copyWith(
      appsTabStep: step,
      isOverlayGranted: overlay,
      isBatteryOptimizationIgnored: battery,
    ));

    if (usage) await _lockEngineCoordinator.syncAll();
  }

  Future<void> fetchInstalledApps() async {
    final result = await _repository.getInstalledApps();
    if (isClosed) return;
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
      emit(state.copyWith(status: ViewStatus.failure));
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
    await _lockEngineCoordinator.syncLockedPackages();
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

  void selectCategory(AppCategory? category) {
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

  /// Opens the Usage Access settings; [refreshPermissions] runs on resume.
  Future<void> enableUsageAccessFromAppsTab() async {
    await _permissionService.requestUsageAccess();
  }

  /// Opens the first missing settings page; [refreshPermissions] runs on
  /// resume and moves on once everything is granted.
  Future<void> fixLimitedPermissions() async {
    if (!state.isOverlayGranted) {
      await _permissionService.requestOverlayPermission();
    } else if (!state.isBatteryOptimizationIgnored) {
      await _permissionService.requestIgnoreBatteryOptimization();
    } else {
      emit(state.copyWith(appsTabStep: AppsTabStep.appList));
    }
  }

  void continueWithLimitedProtection() {
    _limitedWarningDismissed = true;
    emit(state.copyWith(appsTabStep: AppsTabStep.appList));
  }

  List<AppLockItem> _applyFilter(
    List<AppLockItem> list,
    String query,
    bool onlyLocked, [
    AppCategory? category,
  ]) {
    final lowerQuery = query.toLowerCase();
    return list.where((app) {
      final matchesQuery = lowerQuery.isEmpty ||
          app.appName.toLowerCase().contains(lowerQuery) ||
          app.packageName.toLowerCase().contains(lowerQuery);
      final matchesLocked = !onlyLocked || app.isLocked;
      final matchesCategory = category == null || app.category == category;
      return matchesQuery && matchesLocked && matchesCategory;
    }).toList();
  }
}
