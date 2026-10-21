import 'package:injectable/injectable.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/vault/view_model/vault_state.dart';
import 'package:applock/utility/enumeration/vault_step.dart';

@injectable
class VaultViewModel extends BaseCubit<VaultState> {
  VaultViewModel() : super(const VaultState());

  void setStep(VaultStep step) {
    emit(state.copyWith(currentStep: step));
  }

  void openImport({int tabIndex = 0}) {
    final prev = state.currentStep == VaultStep.importMedia
        ? VaultStep.albums
        : state.currentStep;
    emit(state.copyWith(
      previousStepBeforeImport: prev,
      importInitialTabIndex: tabIndex,
      currentStep: VaultStep.importMedia,
    ));
  }

  void startEncrypting({
    required int count,
    required bool deleteOriginals,
  }) {
    emit(state.copyWith(
      importingCount: count,
      deleteOriginalsRequested: deleteOriginals,
      currentStep: VaultStep.encrypting,
    ));
  }

  void completeEncryption() {
    emit(state.copyWith(
      currentStep: state.deleteOriginalsRequested
          ? VaultStep.importCompleteSuccess
          : VaultStep.importCompleteManualDelete,
    ));
  }

  void openPhotoViewer() {
    emit(state.copyWith(
      previousViewerStep: VaultStep.photoViewer,
      currentStep: VaultStep.photoViewer,
    ));
  }

  void openVideoViewer() {
    emit(state.copyWith(
      previousViewerStep: VaultStep.videoViewer,
      currentStep: VaultStep.videoViewer,
    ));
  }

  void openFileInfo(VaultStep fromStep) {
    emit(state.copyWith(
      previousViewerStep: fromStep,
      currentStep: VaultStep.fileInfo,
    ));
  }

  void viewVaultAfterImport() {
    emit(state.copyWith(
      currentStep: state.importInitialTabIndex == 1
          ? VaultStep.videosDetail
          : VaultStep.photosDetail,
    ));
  }
}
