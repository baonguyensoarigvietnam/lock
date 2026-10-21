import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/screen/vault/widget/vault_album_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class _VaultVideoItemData {
  final String title;
  final String subtitle;
  final String duration;
  final List<Color> gradientColors;
  final IconData watermarkIcon;

  const _VaultVideoItemData({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.gradientColors,
    required this.watermarkIcon,
  });
}

class VaultVideosDetailView extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onOpenPhotos;
  final VoidCallback onOpenImport;
  final VoidCallback onOpenVideoViewer;

  static const List<_VaultVideoItemData> _videos = [
    _VaultVideoItemData(
      title: 'Security_Cam_En',
      subtitle: 'Oct 24, 2023 • 12.4 MB',
      duration: '04:22',
      gradientColors: [
        AppColorsPalette.gray800,
        AppColorsPalette.gray400,
        AppColorsPalette.gray700,
      ],
      watermarkIcon: Icons.apartment_rounded,
    ),
    _VaultVideoItemData(
      title: 'Vault_Test_01.mc',
      subtitle: 'Oct 22, 2023 • 4.8 MB',
      duration: '01:15',
      gradientColors: [
        AppColorsPalette.gray100,
        AppColorsPalette.gray300,
        AppColorsPalette.gray500,
      ],
      watermarkIcon: Icons.change_history_rounded,
    ),
    _VaultVideoItemData(
      title: 'Cloud_Sync_Log.',
      subtitle: 'Oct 18, 2023 • 85.2 MB',
      duration: '12:45',
      gradientColors: [
        AppColorsPalette.gray700,
        AppColorsPalette.gray900,
        AppColorsPalette.gray600,
      ],
      watermarkIcon: Icons.dns_rounded,
    ),
    _VaultVideoItemData(
      title: 'Alert_042.mp4',
      subtitle: 'Oct 15, 2023 • 2.1 MB',
      duration: '00:30',
      gradientColors: [
        AppColorsPalette.gray600,
        AppColorsPalette.gray500,
        AppColorsPalette.gray800,
      ],
      watermarkIcon: Icons.meeting_room_outlined,
    ),
    _VaultVideoItemData(
      title: 'Auth_Video_Test.',
      subtitle: 'Oct 10, 2023 • 22.0 MB',
      duration: '05:00',
      gradientColors: [
        AppColorsPalette.gray700,
        AppColorsPalette.gray600,
        AppColorsPalette.gray800,
      ],
      watermarkIcon: Icons.fingerprint_rounded,
    ),
    _VaultVideoItemData(
      title: 'Raw_Feed_Loop.',
      subtitle: 'Oct 05, 2023 • 15.6 MB',
      duration: '03:45',
      gradientColors: [
        AppColorsPalette.gray800,
        AppColorsPalette.gray500,
        AppColorsPalette.gray900,
      ],
      watermarkIcon: Icons.blur_circular_rounded,
    ),
  ];

  const VaultVideosDetailView({
    super.key,
    required this.onBack,
    required this.onOpenPhotos,
    required this.onOpenImport,
    required this.onOpenVideoViewer,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CommonAppBar.back(
              onBack: onBack,
              padding: const EdgeInsets.fromLTRB(12, 8, 20, 8),
              actions: [
                _buildHeaderIconBox(Icons.search_rounded),
                const SizedBox(width: 8),
                _buildHeaderIconBox(Icons.more_vert_rounded),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title & Select button row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Videos',
                              style: AppTypography.bold.copyWith(
                                fontSize: 18,
                                color: AppColorsPalette.black,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '6 items • Protected',
                              style: AppTypography.regular.copyWith(
                                fontSize: 12,
                                color: AppColorsPalette.gray500,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: onOpenImport,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColorsPalette.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColorsPalette.black,
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.check_box_outlined,
                                  size: 15,
                                  color: AppColorsPalette.black,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Select',
                                  style: AppTypography.semiBold.copyWith(
                                    fontSize: 12.5,
                                    color: AppColorsPalette.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // 2-Column Videos Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _videos.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.15,
                      ),
                      itemBuilder: (context, index) {
                        final video = _videos[index];
                        return GestureDetector(
                          onTap: onOpenVideoViewer,
                          behavior: HitTestBehavior.opaque,
                          child: _buildVideoCard(video),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // Bottom Albums section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Albums',
                          style: AppTypography.bold.copyWith(
                            fontSize: 16,
                            color: AppColorsPalette.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: onBack,
                          child: Text(
                            'See all',
                            style: AppTypography.semiBold.copyWith(
                              fontSize: 13,
                              color: AppColorsPalette.gray500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: VaultAlbumCard(
                            title: 'Private Photos',
                            subtitle: '24 items',
                            highlightedCellIndex: 3,
                            onTap: onOpenPhotos,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: VaultAlbumCard(
                            title: 'Galleries',
                            subtitle: '8 items',
                            highlightedCellIndex: 0,
                            onTap: onBack,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Bottom-Right Black Floating Action Button
        Positioned(
          right: 20,
          bottom: 16,
          child: GestureDetector(
            onTap: onOpenImport,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: AppColorsPalette.black,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColorsPalette.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add_rounded,
                color: AppColorsPalette.white,
                size: 28,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoCard(_VaultVideoItemData video) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: video.gradientColors,
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    video.watermarkIcon,
                    size: 42,
                    color: AppColorsPalette.white.withValues(alpha: 0.22),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColorsPalette.black.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      video.duration,
                      style: AppTypography.semiBold.copyWith(
                        fontSize: 10,
                        color: AppColorsPalette.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Text(
                video.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bold.copyWith(
                  fontSize: 13,
                  color: AppColorsPalette.black,
                ),
              ),
            ),
            const Icon(
              Icons.more_vert_rounded,
              size: 16,
              color: AppColorsPalette.gray500,
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          video.subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.regular.copyWith(
            fontSize: 11,
            color: AppColorsPalette.gray500,
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderIconBox(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColorsPalette.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColorsPalette.gray200,
          width: 1,
        ),
      ),
      child: Icon(
        icon,
        size: 18,
        color: AppColorsPalette.black,
      ),
    );
  }
}
