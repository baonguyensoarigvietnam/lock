import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/vault_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class VaultState extends BaseState {
  final VaultStep currentStep;
  final VaultStep previousStepBeforeImport;
  final VaultStep previousViewerStep;
  final int importInitialTabIndex;
  final int importingCount;
  final bool deleteOriginalsRequested;

  const VaultState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.currentStep = VaultStep.empty,
    this.previousStepBeforeImport = VaultStep.albums,
    this.previousViewerStep = VaultStep.photoViewer,
    this.importInitialTabIndex = 0,
    this.importingCount = 5,
    this.deleteOriginalsRequested = true,
  });

  @override
  VaultState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    VaultStep? currentStep,
    VaultStep? previousStepBeforeImport,
    VaultStep? previousViewerStep,
    int? importInitialTabIndex,
    int? importingCount,
    bool? deleteOriginalsRequested,
  }) {
    return VaultState(
      status: status ?? this.status,
      errorMessage:
          errorMessage != null ? errorMessage.value : this.errorMessage,
      currentStep: currentStep ?? this.currentStep,
      previousStepBeforeImport:
          previousStepBeforeImport ?? this.previousStepBeforeImport,
      previousViewerStep: previousViewerStep ?? this.previousViewerStep,
      importInitialTabIndex:
          importInitialTabIndex ?? this.importInitialTabIndex,
      importingCount: importingCount ?? this.importingCount,
      deleteOriginalsRequested:
          deleteOriginalsRequested ?? this.deleteOriginalsRequested,
    );
  }
}
