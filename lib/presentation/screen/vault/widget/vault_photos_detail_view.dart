import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/screen/vault/widget/vault_album_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class VaultPhotosDetailView extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onOpenVideos;
  final VoidCallback onOpenImport;
  final VoidCallback onOpenPhotoViewer;

  const VaultPhotosDetailView({
    super.key,
    required this.onBack,
    required this.onOpenVideos,
    required this.onOpenImport,
    required this.onOpenPhotoViewer,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
                              l10n.albumPhotos,
                              style: AppTypography.bold.copyWith(
                                fontSize: 18,
                                color: AppColorsPalette.black,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n.vaultItemsProtectedSubtitle(24),
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
                                  l10n.selectAction,
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
                    const SizedBox(height: 14),

                    // 3-Column Photo Grid (24 items)
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 24,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: onOpenPhotoViewer,
                          child: const _WireframePhotoCell(),
                        );
                      },
                    ),
                    const SizedBox(height: 24),

                    // Bottom Albums section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.albumsHeader,
                          style: AppTypography.bold.copyWith(
                            fontSize: 16,
                            color: AppColorsPalette.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: onBack,
                          child: Text(
                            l10n.seeAllAction,
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
                            title: l10n.albumVideos,
                            subtitle: l10n.vaultAlbumItemsCount(12),
                            highlightedCellIndex: 3,
                            onTap: onOpenVideos,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: VaultAlbumCard(
                            title: l10n.albumGalleries,
                            subtitle: l10n.vaultAlbumItemsCount(8),
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

class _WireframePhotoCell extends StatelessWidget {
  const _WireframePhotoCell();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColorsPalette.gray150,
        border: Border.all(
          color: AppColorsPalette.gray200,
          width: 0.8,
        ),
      ),
      child: CustomPaint(
        painter: _DiagonalCrossPainter(),
      ),
    );
  }
}

class _DiagonalCrossPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColorsPalette.gray250
      ..strokeWidth = 0.8;

    const pad = 12.0;
    canvas.drawLine(
      const Offset(pad, pad),
      Offset(size.width - pad, size.height - pad),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - pad, pad),
      Offset(pad, size.height - pad),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
