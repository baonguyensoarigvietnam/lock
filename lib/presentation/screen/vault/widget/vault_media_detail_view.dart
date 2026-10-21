import 'package:flutter/material.dart';
import 'package:applock/domain/model/vault_item.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/screen/vault/widget/vault_album_card.dart';
import 'package:applock/presentation/screen/vault/widget/vault_format_helper.dart';
import 'package:applock/presentation/screen/vault/widget/vault_thumbnail.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

/// Album detail listing either the vault photos or the vault videos.
class VaultMediaDetailView extends StatelessWidget {
  final VaultMediaType type;
  final List<VaultItem> items;

  /// Items of the other album, shown in the bottom "Albums" section.
  final List<VaultItem> otherAlbumItems;
  final VoidCallback onBack;
  final VoidCallback onOpenOtherAlbum;
  final VoidCallback onImport;
  final ValueChanged<VaultItem> onOpenItem;

  const VaultMediaDetailView({
    super.key,
    required this.type,
    required this.items,
    required this.otherAlbumItems,
    required this.onBack,
    required this.onOpenOtherAlbum,
    required this.onImport,
    required this.onOpenItem,
  });

  bool get _isPhotos => type == VaultMediaType.photo;

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
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isPhotos ? l10n.albumPhotos : l10n.albumVideos,
                      style: AppTypography.bold.copyWith(
                        fontSize: 18,
                        color: AppColorsPalette.black,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      l10n.vaultItemsProtectedSubtitle(items.length),
                      style: AppTypography.regular.copyWith(
                        fontSize: 12,
                        color: AppColorsPalette.gray500,
                      ),
                    ),
                    const SizedBox(height: 14),
                    if (items.isEmpty)
                      _buildEmptyState(context)
                    else if (_isPhotos)
                      _buildPhotoGrid()
                    else
                      _buildVideoGrid(context),
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
                            title: _isPhotos
                                ? l10n.albumVideos
                                : l10n.albumPhotos,
                            subtitle: l10n.vaultAlbumItemsCount(
                              otherAlbumItems.length,
                            ),
                            previewItems: otherAlbumItems.take(4).toList(),
                            onTap: onOpenOtherAlbum,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(child: SizedBox.shrink()),
                      ],
                    ),
                    // Space for the floating action button.
                    const SizedBox(height: 84),
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
            onTap: onImport,
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

  Widget _buildEmptyState(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 32),
      decoration: BoxDecoration(
        color: AppColorsPalette.gray50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColorsPalette.gray200, width: 1),
      ),
      child: Column(
        children: [
          Icon(
            _isPhotos ? Icons.image_outlined : Icons.movie_creation_outlined,
            size: 40,
            color: AppColorsPalette.gray400,
          ),
          const SizedBox(height: 12),
          Text(
            _isPhotos ? l10n.vaultPhotosEmptyTitle : l10n.vaultVideosEmptyTitle,
            textAlign: TextAlign.center,
            style: AppTypography.bold.copyWith(
              fontSize: 16,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.vaultDetailEmptySubtitle,
            textAlign: TextAlign.center,
            style: AppTypography.regular.copyWith(
              fontSize: 13,
              color: AppColorsPalette.gray500,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () => onOpenItem(item),
          child: VaultThumbnail(
            key: ValueKey(item.id),
            item: item,
          ),
        );
      },
    );
  }

  Widget _buildVideoGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 1.15,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () => onOpenItem(item),
          behavior: HitTestBehavior.opaque,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: VaultThumbnail(
                    key: ValueKey(item.id),
                    item: item,
                    iconSize: 42,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.originalName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.bold.copyWith(
                  fontSize: 13,
                  color: AppColorsPalette.black,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                VaultFormatHelper.itemSubtitle(context, item),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.regular.copyWith(
                  fontSize: 11,
                  color: AppColorsPalette.gray500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
