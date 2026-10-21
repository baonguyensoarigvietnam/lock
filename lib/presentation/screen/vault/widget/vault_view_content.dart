import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/application/view_model/global_view_model.dart';
import 'package:applock/domain/model/vault_item.dart';
import 'package:applock/domain/repository/vault_repository.dart';
import 'package:applock/presentation/screen/vault/vault_navigator.dart';
import 'package:applock/presentation/screen/vault/view_model/vault_state.dart';
import 'package:applock/presentation/screen/vault/view_model/vault_view_model.dart';
import 'package:applock/presentation/screen/vault/widget/vault_encrypting_view.dart';
import 'package:applock/presentation/screen/vault/widget/vault_file_info_view.dart';
import 'package:applock/presentation/screen/vault/widget/vault_import_complete_view.dart';
import 'package:applock/presentation/screen/vault/widget/vault_media_detail_view.dart';
import 'package:applock/presentation/screen/vault/widget/vault_overview_section.dart';
import 'package:applock/presentation/screen/vault/widget/vault_photo_viewer_view.dart';
import 'package:applock/presentation/screen/vault/widget/vault_video_viewer_view.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/utility/dialog_utility.dart';
import 'package:applock/utility/enumeration/vault_step.dart';
import 'package:applock/utility/extension/build_context.dart';

class VaultViewContent extends StatelessWidget {
  const VaultViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    final isPremium = context.select<GlobalViewModel, bool>(
      (vm) => vm.state.isPremium,
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<VaultViewModel, VaultState>(
          listenWhen: (previous, current) =>
              previous.limitReachedEvent != current.limitReachedEvent,
          listener: (context, _) => _showLimitReachedSheet(context),
        ),
        BlocListener<VaultViewModel, VaultState>(
          listenWhen: (previous, current) =>
              previous.failureEvent != current.failureEvent,
          listener: (context, _) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(context.l10n.vaultOperationFailed)),
              );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColorsPalette.white,
        body: SafeArea(
          child: BlocBuilder<VaultViewModel, VaultState>(
            builder: (context, state) {
              if (!state.hasLoaded) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColorsPalette.black,
                  ),
                );
              }
              return _buildStepContent(context, state, isPremium);
            },
          ),
        ),
      ),
    );
  }

  void _showLimitReachedSheet(BuildContext context) {
    final l10n = context.l10n;
    final navigator = context.read<VaultNavigator>();
    DialogUtility.showConfirmBottomSheet(
      context: context,
      icon: Icons.workspace_premium_outlined,
      title: l10n.vaultLimitReachedTitle,
      description: l10n.vaultLimitReachedDesc(VaultRepository.freePlanItemLimit),
      primaryButtonText: l10n.vaultUpgradeButton,
      secondaryButtonText: l10n.cancelButton,
      onPrimaryTap: navigator.goToPaywall,
    );
  }

  Widget _buildStepContent(
    BuildContext context,
    VaultState state,
    bool isPremium,
  ) {
    final vm = context.read<VaultViewModel>();

    void importPhotos() =>
        vm.importMedia(type: VaultMediaType.photo, isPremium: isPremium);
    void importVideos() =>
        vm.importMedia(type: VaultMediaType.video, isPremium: isPremium);

    switch (state.currentStep) {
      case VaultStep.empty:
      case VaultStep.albums:
        return VaultOverviewSection(
          photos: state.photos,
          videos: state.videos,
          isPremium: isPremium,
          freePlanLimit: VaultRepository.freePlanItemLimit,
          onAddPhotos: importPhotos,
          onAddVideos: importVideos,
          onOpenPhotos: () => vm.setStep(VaultStep.photosDetail),
          onOpenVideos: () => vm.setStep(VaultStep.videosDetail),
        );
      case VaultStep.photosDetail:
        return VaultMediaDetailView(
          type: VaultMediaType.photo,
          items: state.photos,
          otherAlbumItems: state.videos,
          onBack: vm.goToOverview,
          onOpenOtherAlbum: () => vm.setStep(VaultStep.videosDetail),
          onImport: importPhotos,
          onOpenItem: vm.openPhotoViewer,
        );
      case VaultStep.videosDetail:
        return VaultMediaDetailView(
          type: VaultMediaType.video,
          items: state.videos,
          otherAlbumItems: state.photos,
          onBack: vm.goToOverview,
          onOpenOtherAlbum: () => vm.setStep(VaultStep.photosDetail),
          onImport: importVideos,
          onOpenItem: vm.openVideoViewer,
        );
      case VaultStep.encrypting:
        return VaultEncryptingView(
          totalFiles: state.importTotal,
          processedFiles: state.importProcessed,
        );
      case VaultStep.importCompleteManualDelete:
        return VaultImportCompleteView(
          encryptedCount: state.importedCount,
          onViewVault: vm.viewVaultAfterImport,
          onBackToVaultHome: vm.goToOverview,
        );
      case VaultStep.photoViewer:
        return VaultPhotoViewerView(
          fileName: state.selectedItem?.originalName ?? '',
          imageBytes: state.viewerPhotoBytes,
          isLoading: state.isViewerLoading,
          onBack: vm.closeViewer,
          onDelete: vm.deleteSelectedItem,
          onInfo: vm.openFileInfo,
        );
      case VaultStep.videoViewer:
        return VaultVideoViewerView(
          fileName: state.selectedItem?.originalName ?? '',
          videoPath: state.viewerVideoPath,
          isLoading: state.isViewerLoading,
          onBack: vm.closeViewer,
          onDeleteConfirmed: vm.deleteSelectedItem,
          onInfo: vm.openFileInfo,
          onReleaseTempFile: vm.releaseVideoTempFile,
        );
      case VaultStep.fileInfo:
        final item = state.selectedItem;
        if (item == null) {
          return VaultOverviewSection(
            photos: state.photos,
            videos: state.videos,
            isPremium: isPremium,
            freePlanLimit: VaultRepository.freePlanItemLimit,
            onAddPhotos: importPhotos,
            onAddVideos: importVideos,
            onOpenPhotos: () => vm.setStep(VaultStep.photosDetail),
            onOpenVideos: () => vm.setStep(VaultStep.videosDetail),
          );
        }
        return VaultFileInfoView(
          item: item,
          onBack: vm.closeFileInfo,
        );
    }
  }
}
