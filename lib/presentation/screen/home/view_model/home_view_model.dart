import 'package:injectable/injectable.dart';
import 'package:applock/domain/model/app_lock_item.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/home/view_model/home_state.dart';
import 'package:applock/service/app_lock/app_lock_service.dart';
import 'package:applock/service/app_lock/biometric_service.dart';
import 'package:applock/service/permission/permission_service.dart';
import 'package:applock/utility/enumeration/apps_filter_tab.dart';
import 'package:applock/utility/enumeration/apps_tab_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';
import 'package:applock/utility/helper/result.dart';

@injectable
class HomeViewModel extends BaseCubit<HomeState> {
  final AppLockRepository _repository;
  final PermissionService _permissionService;
  final AppLockService _appLockService;
  final BiometricService _biometricService;

  HomeViewModel(
    this._repository,
    this._permissionService,
    this._appLockService,
    this._biometricService,
  ) : super(const HomeState());

  Future<void> init() async {
    emit(state.copyWith(status: ViewStatus.loading));

    final isOverlay = await _permissionService.isOverlayPermissionGranted();
    final configRes = await _repository.getLockConfig();
    var isService = false;
    var isBio = false;

    if (configRes is Success) {
      final config = (configRes as Success).data;
      isService = config.isServiceActive;
      isBio = config.isBiometricEnabled;
    }

    emit(state.copyWith(
      isOverlayGranted: isOverlay,
      isServiceActive: isService,
      isBiometricEnabled: isBio,
    ));

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

    // Optimistic update
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

  void toggleOnlyLockedFilter() {
    final newFilter = !state.onlyLockedFilter;
    emit(state.copyWith(
      onlyLockedFilter: newFilter,
      appsFilterTab: newFilter ? AppsFilterTab.locked : AppsFilterTab.all,
      filteredApps: _applyFilter(
        state.apps,
        state.searchQuery,
        newFilter,
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

  void setAppsTabStep(AppsTabStep step) {
    emit(state.copyWith(appsTabStep: step));
  }

  Future<void> toggleService(bool active) async {
    if (active) {
      final granted = await _permissionService.isOverlayPermissionGranted();
      if (!granted) {
        emit(state.copyWith(isOverlayGranted: false));
        return;
      }
      await _appLockService.startService();
    } else {
      await _appLockService.stopService();
    }
    await _repository.setServiceActive(active);
    emit(state.copyWith(isServiceActive: active));
  }

  Future<void> toggleBiometric(bool active) async {
    if (active) {
      final canCheck = await _biometricService.canCheckBiometrics();
      if (!canCheck) {
        emitError('Thiết bị không hỗ trợ hoặc chưa cài sinh trắc học');
        return;
      }
      final authenticated = await _biometricService.authenticate();
      if (!authenticated) return;
    }
    await _repository.setBiometricEnabled(active);
    emit(state.copyWith(isBiometricEnabled: active));
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
