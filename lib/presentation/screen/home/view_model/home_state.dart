import 'package:applock/domain/model/app_lock_item.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/apps_filter_tab.dart';
import 'package:applock/utility/enumeration/apps_tab_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class HomeState extends BaseState {
  final List<AppLockItem> apps;
  final List<AppLockItem> filteredApps;
  final String searchQuery;
  final bool isServiceActive;
  final bool isBiometricEnabled;
  final bool onlyLockedFilter;
  final bool isOverlayGranted;
  final AppsTabStep appsTabStep;
  final AppsFilterTab appsFilterTab;
  final String? selectedCategory;

  const HomeState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.apps = const [],
    this.filteredApps = const [],
    this.searchQuery = '',
    this.isServiceActive = false,
    this.isBiometricEnabled = false,
    this.onlyLockedFilter = false,
    this.isOverlayGranted = false,
    this.appsTabStep = AppsTabStep.usageAccessRequired,
    this.appsFilterTab = AppsFilterTab.all,
    this.selectedCategory,
  });

  int get lockedCount => apps.where((a) => a.isLocked).length;

  @override
  HomeState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    List<AppLockItem>? apps,
    List<AppLockItem>? filteredApps,
    String? searchQuery,
    bool? isServiceActive,
    bool? isBiometricEnabled,
    bool? onlyLockedFilter,
    bool? isOverlayGranted,
    AppsTabStep? appsTabStep,
    AppsFilterTab? appsFilterTab,
    Nullable<String>? selectedCategory,
  }) {
    return HomeState(
      status: status ?? this.status,
      errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
      apps: apps ?? this.apps,
      filteredApps: filteredApps ?? this.filteredApps,
      searchQuery: searchQuery ?? this.searchQuery,
      isServiceActive: isServiceActive ?? this.isServiceActive,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      onlyLockedFilter: onlyLockedFilter ?? this.onlyLockedFilter,
      isOverlayGranted: isOverlayGranted ?? this.isOverlayGranted,
      appsTabStep: appsTabStep ?? this.appsTabStep,
      appsFilterTab: appsFilterTab ?? this.appsFilterTab,
      selectedCategory: selectedCategory != null
          ? selectedCategory.value
          : this.selectedCategory,
    );
  }
}
