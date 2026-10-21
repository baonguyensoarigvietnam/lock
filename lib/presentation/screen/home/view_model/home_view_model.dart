import 'package:injectable/injectable.dart';
import 'package:applock/domain/model/app_lock_item.dart';
import 'package:applock/domain/repository/app_lock_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/home/view_model/home_state.dart';
import 'package:applock/service/app_lock/app_lock_service.dart';
import 'package:applock/service/app_lock/biometric_service.dart';
import 'package:applock/service/permission/permission_service.dart';
import 'package:applock/utility/enumeration/view_status.dart';
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
        filteredApps: _applyFilter(apps, state.searchQuery, state.onlyLockedFilter),
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
      ),
    ));

    await _repository.toggleLockApp(packageName, newLocked);
  }

  void search(String query) {
    emit(state.copyWith(
      searchQuery: query,
      filteredApps: _applyFilter(state.apps, query, state.onlyLockedFilter),
    ));
  }

  void toggleOnlyLockedFilter() {
    final newFilter = !state.onlyLockedFilter;
    emit(state.copyWith(
      onlyLockedFilter: newFilter,
      filteredApps: _applyFilter(state.apps, state.searchQuery, newFilter),
    ));
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
    bool onlyLocked,
  ) {
    return list.where((app) {
      final matchesQuery = query.isEmpty ||
          app.appName.toLowerCase().contains(query.toLowerCase()) ||
          app.packageName.toLowerCase().contains(query.toLowerCase());
      final matchesLocked = !onlyLocked || app.isLocked;
      return matchesQuery && matchesLocked;
    }).toList();
  }
}
