import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/screen/vault/view_model/vault_state.dart';
import 'package:applock/presentation/screen/vault/view_model/vault_view_model.dart';
import 'package:applock/presentation/screen/vault/widget/vault_album_card.dart';
import 'package:applock/presentation/screen/vault/widget/vault_encrypting_view.dart';
import 'package:applock/presentation/screen/vault/widget/vault_file_info_view.dart';
import 'package:applock/presentation/screen/vault/widget/vault_import_complete_view.dart';
import 'package:applock/presentation/screen/vault/widget/vault_import_view.dart';
import 'package:applock/presentation/screen/vault/widget/vault_photo_viewer_view.dart';
import 'package:applock/presentation/screen/vault/widget/vault_photos_detail_view.dart';
import 'package:applock/presentation/screen/vault/widget/vault_video_viewer_view.dart';
import 'package:applock/presentation/screen/vault/widget/vault_videos_detail_view.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/enumeration/vault_step.dart';

class VaultViewContent extends StatelessWidget {
  const VaultViewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPalette.white,
      body: SafeArea(
        child: BlocBuilder<VaultViewModel, VaultState>(
          builder: (context, state) {
            return _buildStepContent(context, state);
          },
        ),
      ),
    );
  }

  Widget _buildStepContent(BuildContext context, VaultState state) {
    final vm = context.read<VaultViewModel>();

    switch (state.currentStep) {
      case VaultStep.empty:
        return _buildMainVaultOverview(context, isEmpty: true);
      case VaultStep.albums:
        return _buildMainVaultOverview(context, isEmpty: false);
      case VaultStep.photosDetail:
        return VaultPhotosDetailView(
          onBack: () => vm.setStep(VaultStep.albums),
          onOpenVideos: () => vm.setStep(VaultStep.videosDetail),
          onOpenImport: () => vm.openImport(tabIndex: 0),
          onOpenPhotoViewer: () => vm.openPhotoViewer(),
        );
      case VaultStep.videosDetail:
        return VaultVideosDetailView(
          onBack: () => vm.setStep(VaultStep.albums),
          onOpenPhotos: () => vm.setStep(VaultStep.photosDetail),
          onOpenImport: () => vm.openImport(tabIndex: 1),
          onOpenVideoViewer: () => vm.openVideoViewer(),
        );
      case VaultStep.importMedia:
        return VaultImportView(
          initialTabIndex: state.importInitialTabIndex,
          onBack: () => vm.setStep(state.previousStepBeforeImport),
          onImportAndDelete: (count) => vm.startEncrypting(
            count: count,
            deleteOriginals: true,
          ),
          onImportOnly: (count) => vm.startEncrypting(
            count: count,
            deleteOriginals: false,
          ),
        );
      case VaultStep.encrypting:
        return VaultEncryptingView(
          totalFiles: state.importingCount,
          onComplete: () => vm.completeEncryption(),
        );
      case VaultStep.importCompleteSuccess:
        return VaultImportCompleteView(
          encryptedCount: state.importingCount,
          originalsDeleted: true,
          onToggleVariant: () =>
              vm.setStep(VaultStep.importCompleteManualDelete),
          onViewVault: () => vm.viewVaultAfterImport(),
          onBackToVaultHome: () => vm.setStep(VaultStep.albums),
        );
      case VaultStep.importCompleteManualDelete:
        return VaultImportCompleteView(
          encryptedCount: state.importingCount,
          originalsDeleted: false,
          onToggleVariant: () => vm.setStep(VaultStep.importCompleteSuccess),
          onViewVault: () => vm.viewVaultAfterImport(),
          onBackToVaultHome: () => vm.setStep(VaultStep.albums),
        );
      case VaultStep.photoViewer:
        return VaultPhotoViewerView(
          onBack: () => vm.setStep(VaultStep.photosDetail),
          onRestore: () => vm.setStep(VaultStep.photosDetail),
          onDelete: () => vm.setStep(VaultStep.photosDetail),
          onInfo: () => vm.openFileInfo(VaultStep.photoViewer),
        );
      case VaultStep.videoViewer:
        return VaultVideoViewerView(
          onBack: () => vm.setStep(VaultStep.videosDetail),
          onRestoreConfirmed: () => vm.setStep(VaultStep.videosDetail),
          onDeleteConfirmed: () => vm.setStep(VaultStep.videosDetail),
          onInfo: () => vm.openFileInfo(VaultStep.videoViewer),
        );
      case VaultStep.fileInfo:
        return VaultFileInfoView(
          onBack: () => vm.setStep(state.previousViewerStep),
        );
    }
  }

  Widget _buildMainVaultOverview(BuildContext context, {required bool isEmpty}) {
    final vm = context.read<VaultViewModel>();
    final protectedItemsText =
        isEmpty ? '0/100 items protected' : '48/100 items protected';

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const CommonAppBar.brand(),
          const SizedBox(height: 18),

          // Summary Card (tapping toggles between 0/100 empty state and 48/100 albums state)
          GestureDetector(
            onTap: () {
              vm.setStep(isEmpty ? VaultStep.albums : VaultStep.empty);
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: AppColorsPalette.gray50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: AppColorsPalette.gray200,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        protectedItemsText,
                        style: AppTypography.bold.copyWith(
                          fontSize: 21,
                          color: AppColorsPalette.black,
                        ),
                      ),
                      const Icon(
                        Icons.verified_user_rounded,
                        color: AppColorsPalette.black,
                        size: 22,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.lock_outline_rounded,
                        size: 15,
                        color: AppColorsPalette.gray500,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Encrypted on this device',
                        style: AppTypography.regular.copyWith(
                          fontSize: 13,
                          color: AppColorsPalette.gray500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 22),

          // Quick Actions Header
          Text(
            'Quick actions',
            style: AppTypography.bold.copyWith(
              fontSize: 16,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(height: 12),

          // Quick Actions Buttons Row
          Row(
            children: [
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.add_photo_alternate_outlined,
                  label: 'Add\nPhotos',
                  isFilled: true,
                  onTap: () => vm.openImport(tabIndex: 0),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.movie_creation_outlined,
                  label: 'Import\nVideos',
                  isFilled: false,
                  onTap: () => vm.openImport(tabIndex: 1),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.create_new_folder_outlined,
                  label: 'Create\nAlbum',
                  isFilled: false,
                  onTap: () => vm.setStep(VaultStep.albums),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Albums Section Header
          Text(
            'Albums',
            style: AppTypography.bold.copyWith(
              fontSize: 16,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(height: 14),

          if (isEmpty)
            _buildEmptyVaultState()
          else
            _buildAlbumsGrid(vm),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required bool isFilled,
    required VoidCallback onTap,
  }) {
    final bgColor = isFilled ? AppColorsPalette.black : AppColorsPalette.gray50;
    final fgColor = isFilled ? AppColorsPalette.white : AppColorsPalette.black;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: isFilled
              ? null
              : Border.all(
                  color: AppColorsPalette.gray200,
                  width: 1,
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: fgColor,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: AppTypography.semiBold.copyWith(
                  fontSize: 12.5,
                  color: fgColor,
                  height: 1.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyVaultState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              width: 124,
              height: 124,
              child: Stack(
                children: [
                  Container(
                    width: 116,
                    height: 116,
                    decoration: BoxDecoration(
                      color: AppColorsPalette.gray100,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColorsPalette.gray200,
                        width: 1,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.lock_outline_rounded,
                        size: 48,
                        color: AppColorsPalette.gray500,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColorsPalette.gray50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: AppColorsPalette.gray200,
                          width: 1,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.create_new_folder_outlined,
                          size: 22,
                          color: AppColorsPalette.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'Your vault is empty',
              textAlign: TextAlign.center,
              style: AppTypography.bold.copyWith(
                fontSize: 20,
                color: AppColorsPalette.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Import photos and videos to keep them\nencrypted on this device.',
              textAlign: TextAlign.center,
              style: AppTypography.regular.copyWith(
                fontSize: 14,
                color: AppColorsPalette.gray500,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumsGrid(VaultViewModel vm) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.78,
      children: [
        VaultAlbumCard(
          title: 'Private Photos',
          subtitle: '24 items',
          highlightedCellIndex: 2,
          onTap: () => vm.setStep(VaultStep.photosDetail),
        ),
        VaultAlbumCard(
          title: 'Videos',
          subtitle: '6 items',
          highlightedCellIndex: 3,
          onTap: () => vm.setStep(VaultStep.videosDetail),
        ),
        VaultAlbumCard(
          title: 'Galleries',
          subtitle: '8 items',
          highlightedCellIndex: 0,
          onTap: () => vm.setStep(VaultStep.photosDetail),
        ),
        VaultAlbumCard(
          title: 'Screenshots',
          subtitle: '10 items',
          highlightedCellIndex: 1,
          onTap: () => vm.setStep(VaultStep.photosDetail),
        ),
      ],
    );
  }
}
