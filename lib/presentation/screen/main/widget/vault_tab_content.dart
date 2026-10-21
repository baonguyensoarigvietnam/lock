import 'package:flutter/material.dart';
import 'package:applock/presentation/screen/main/widget/vault_album_card.dart';
import 'package:applock/presentation/screen/main/widget/vault_encrypting_view.dart';
import 'package:applock/presentation/screen/main/widget/vault_file_info_view.dart';
import 'package:applock/presentation/screen/main/widget/vault_import_complete_view.dart';
import 'package:applock/presentation/screen/main/widget/vault_import_view.dart';
import 'package:applock/presentation/screen/main/widget/vault_photo_viewer_view.dart';
import 'package:applock/presentation/screen/main/widget/vault_photos_detail_view.dart';
import 'package:applock/presentation/screen/main/widget/vault_video_viewer_view.dart';
import 'package:applock/presentation/screen/main/widget/vault_videos_detail_view.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/enumeration/vault_step.dart';

class VaultTabContent extends StatefulWidget {
  const VaultTabContent({super.key});

  @override
  State<VaultTabContent> createState() => _VaultTabContentState();
}

class _VaultTabContentState extends State<VaultTabContent> {
  VaultStep _currentStep = VaultStep.empty;
  VaultStep _previousStepBeforeImport = VaultStep.albums;
  VaultStep _previousViewerStep = VaultStep.photoViewer;
  int _importInitialTabIndex = 0;
  int _importingCount = 5;
  bool _deleteOriginalsRequested = true;

  void _openImport({int tabIndex = 0}) {
    setState(() {
      _previousStepBeforeImport = _currentStep == VaultStep.importMedia
          ? VaultStep.albums
          : _currentStep;
      _importInitialTabIndex = tabIndex;
      _currentStep = VaultStep.importMedia;
    });
  }

  void _startEncrypting({
    required int count,
    required bool deleteOriginals,
  }) {
    setState(() {
      _importingCount = count;
      _deleteOriginalsRequested = deleteOriginals;
      _currentStep = VaultStep.encrypting;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsPalette.white,
      body: SafeArea(
        child: _buildStepContent(),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case VaultStep.empty:
        return _buildMainVaultOverview(isEmpty: true);
      case VaultStep.albums:
        return _buildMainVaultOverview(isEmpty: false);
      case VaultStep.photosDetail:
        return VaultPhotosDetailView(
          onBack: () => setState(() => _currentStep = VaultStep.albums),
          onOpenVideos: () =>
              setState(() => _currentStep = VaultStep.videosDetail),
          onOpenImport: () => _openImport(tabIndex: 0),
          onOpenPhotoViewer: () => setState(() {
            _previousViewerStep = VaultStep.photoViewer;
            _currentStep = VaultStep.photoViewer;
          }),
        );
      case VaultStep.videosDetail:
        return VaultVideosDetailView(
          onBack: () => setState(() => _currentStep = VaultStep.albums),
          onOpenPhotos: () =>
              setState(() => _currentStep = VaultStep.photosDetail),
          onOpenImport: () => _openImport(tabIndex: 1),
          onOpenVideoViewer: () => setState(() {
            _previousViewerStep = VaultStep.videoViewer;
            _currentStep = VaultStep.videoViewer;
          }),
        );
      case VaultStep.importMedia:
        return VaultImportView(
          initialTabIndex: _importInitialTabIndex,
          onBack: () => setState(() => _currentStep = _previousStepBeforeImport),
          onImportAndDelete: (count) => _startEncrypting(
            count: count,
            deleteOriginals: true,
          ),
          onImportOnly: (count) => _startEncrypting(
            count: count,
            deleteOriginals: false,
          ),
        );
      case VaultStep.encrypting:
        return VaultEncryptingView(
          totalFiles: _importingCount,
          onComplete: () {
            setState(() {
              _currentStep = _deleteOriginalsRequested
                  ? VaultStep.importCompleteSuccess
                  : VaultStep.importCompleteManualDelete;
            });
          },
        );
      case VaultStep.importCompleteSuccess:
        return VaultImportCompleteView(
          encryptedCount: _importingCount,
          originalsDeleted: true,
          onToggleVariant: () {
            setState(() {
              _currentStep = VaultStep.importCompleteManualDelete;
            });
          },
          onViewVault: () {
            setState(() {
              _currentStep = _importInitialTabIndex == 1
                  ? VaultStep.videosDetail
                  : VaultStep.photosDetail;
            });
          },
          onBackToVaultHome: () {
            setState(() {
              _currentStep = VaultStep.albums;
            });
          },
        );
      case VaultStep.importCompleteManualDelete:
        return VaultImportCompleteView(
          encryptedCount: _importingCount,
          originalsDeleted: false,
          onToggleVariant: () {
            setState(() {
              _currentStep = VaultStep.importCompleteSuccess;
            });
          },
          onViewVault: () {
            setState(() {
              _currentStep = _importInitialTabIndex == 1
                  ? VaultStep.videosDetail
                  : VaultStep.photosDetail;
            });
          },
          onBackToVaultHome: () {
            setState(() {
              _currentStep = VaultStep.albums;
            });
          },
        );
      case VaultStep.photoViewer:
        return VaultPhotoViewerView(
          onBack: () => setState(() => _currentStep = VaultStep.photosDetail),
          onRestore: () =>
              setState(() => _currentStep = VaultStep.photosDetail),
          onDelete: () => setState(() => _currentStep = VaultStep.photosDetail),
          onInfo: () => setState(() {
            _previousViewerStep = VaultStep.photoViewer;
            _currentStep = VaultStep.fileInfo;
          }),
        );
      case VaultStep.videoViewer:
        return VaultVideoViewerView(
          onBack: () => setState(() => _currentStep = VaultStep.videosDetail),
          onRestoreConfirmed: () =>
              setState(() => _currentStep = VaultStep.videosDetail),
          onDeleteConfirmed: () =>
              setState(() => _currentStep = VaultStep.videosDetail),
          onInfo: () => setState(() {
            _previousViewerStep = VaultStep.videoViewer;
            _currentStep = VaultStep.fileInfo;
          }),
        );
      case VaultStep.fileInfo:
        return VaultFileInfoView(
          onBack: () => setState(() => _currentStep = _previousViewerStep),
        );
    }
  }

  Widget _buildMainVaultOverview({required bool isEmpty}) {
    final protectedItemsText =
        isEmpty ? '0/100 items protected' : '48/100 items protected';

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          // Top Title: App Lock
          Center(
            child: Text(
              'App Lock',
              style: AppTypography.bold.copyWith(
                fontSize: 20,
                color: AppColorsPalette.black,
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Summary Card (tapping toggles between 0/100 empty state and 48/100 albums state)
          GestureDetector(
            onTap: () {
              setState(() {
                _currentStep = isEmpty ? VaultStep.albums : VaultStep.empty;
              });
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
                  onTap: () => _openImport(tabIndex: 0),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.movie_creation_outlined,
                  label: 'Import\nVideos',
                  isFilled: false,
                  onTap: () => _openImport(tabIndex: 1),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.create_new_folder_outlined,
                  label: 'Create\nAlbum',
                  isFilled: false,
                  onTap: () {
                    setState(() {
                      _currentStep = VaultStep.albums;
                    });
                  },
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
            _buildAlbumsGrid(),

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
            // Lock Circle + Folder Badge Illustration
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

  Widget _buildAlbumsGrid() {
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
          onTap: () => setState(() => _currentStep = VaultStep.photosDetail),
        ),
        VaultAlbumCard(
          title: 'Videos',
          subtitle: '6 items',
          highlightedCellIndex: 3,
          onTap: () => setState(() => _currentStep = VaultStep.videosDetail),
        ),
        VaultAlbumCard(
          title: 'Galleries',
          subtitle: '8 items',
          highlightedCellIndex: 0,
          onTap: () => setState(() => _currentStep = VaultStep.photosDetail),
        ),
        VaultAlbumCard(
          title: 'Screenshots',
          subtitle: '10 items',
          highlightedCellIndex: 1,
          onTap: () => setState(() => _currentStep = VaultStep.photosDetail),
        ),
      ],
    );
  }
}
