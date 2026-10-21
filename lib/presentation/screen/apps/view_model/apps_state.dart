import 'package:applock/domain/model/app_lock_item.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/apps_filter_tab.dart';
import 'package:applock/utility/enumeration/apps_tab_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class AppsState extends BaseState {
  final List<AppLockItem> apps;
  final List<AppLockItem> filteredApps;
  final String searchQuery;
  final bool onlyLockedFilter;
  final AppsTabStep appsTabStep;
  final AppsFilterTab appsFilterTab;
  final String? selectedCategory;

  const AppsState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.apps = const [],
    this.filteredApps = const [],
    this.searchQuery = '',
    this.onlyLockedFilter = false,
    this.appsTabStep = AppsTabStep.usageAccessRequired,
    this.appsFilterTab = AppsFilterTab.all,
    this.selectedCategory,
  });

  int get lockedCount => apps.where((a) => a.isLocked).length;

  @override
  AppsState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    List<AppLockItem>? apps,
    List<AppLockItem>? filteredApps,
    String? searchQuery,
    bool? onlyLockedFilter,
    AppsTabStep? appsTabStep,
    AppsFilterTab? appsFilterTab,
    Nullable<String>? selectedCategory,
  }) {
    return AppsState(
      status: status ?? this.status,
      errorMessage:
          errorMessage != null ? errorMessage.value : this.errorMessage,
      apps: apps ?? this.apps,
      filteredApps: filteredApps ?? this.filteredApps,
      searchQuery: searchQuery ?? this.searchQuery,
      onlyLockedFilter: onlyLockedFilter ?? this.onlyLockedFilter,
      appsTabStep: appsTabStep ?? this.appsTabStep,
      appsFilterTab: appsFilterTab ?? this.appsFilterTab,
      selectedCategory: selectedCategory != null
          ? selectedCategory.value
          : this.selectedCategory,
    );
  }
}
