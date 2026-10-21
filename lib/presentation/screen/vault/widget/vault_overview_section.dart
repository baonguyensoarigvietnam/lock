import 'package:flutter/material.dart';
import 'package:applock/domain/model/vault_item.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/screen/vault/widget/vault_album_card.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

/// Vault home: summary card, quick import actions and albums (or empty state).
class VaultOverviewSection extends StatelessWidget {
  final List<VaultItem> photos;
  final List<VaultItem> videos;
  final bool isPremium;
  final int freePlanLimit;
  final VoidCallback onAddPhotos;
  final VoidCallback onAddVideos;
  final VoidCallback onOpenPhotos;
  final VoidCallback onOpenVideos;

  const VaultOverviewSection({
    super.key,
    required this.photos,
    required this.videos,
    required this.isPremium,
    required this.freePlanLimit,
    required this.onAddPhotos,
    required this.onAddVideos,
    required this.onOpenPhotos,
    required this.onOpenVideos,
  });

  int get _total => photos.length + videos.length;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final protectedItemsText = isPremium
        ? l10n.vaultItemsProtectedUnlimited(_total)
        : l10n.itemsProtectedCount(_total);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const CommonAppBar.brand(),
          const SizedBox(height: 18),

          // Summary Card
          Container(
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
                    Flexible(
                      child: Text(
                        protectedItemsText,
                        style: AppTypography.bold.copyWith(
                          fontSize: 21,
                          color: AppColorsPalette.black,
                        ),
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
                      l10n.encryptedOnThisDevice,
                      style: AppTypography.regular.copyWith(
                        fontSize: 13,
                        color: AppColorsPalette.gray500,
                      ),
                    ),
                  ],
                ),
                if (!isPremium) ...[
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: (_total / freePlanLimit).clamp(0.0, 1.0),
                      minHeight: 5,
                      backgroundColor: AppColorsPalette.gray200,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColorsPalette.black,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 22),

          // Quick Actions Header
          Text(
            l10n.quickActionsSmallTitle,
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
                  label: l10n.addPhotosAction,
                  isFilled: true,
                  onTap: onAddPhotos,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildQuickActionButton(
                  icon: Icons.movie_creation_outlined,
                  label: l10n.importVideosAction,
                  isFilled: false,
                  onTap: onAddVideos,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Albums Section Header
          Text(
            l10n.albumsHeader,
            style: AppTypography.bold.copyWith(
              fontSize: 16,
              color: AppColorsPalette.black,
            ),
          ),
          const SizedBox(height: 14),

          if (_total == 0)
            _buildEmptyVaultState(context)
          else
            _buildAlbumsGrid(context),

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

  Widget _buildEmptyVaultState(BuildContext context) {
    final l10n = context.l10n;
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
                          Icons.add_photo_alternate_outlined,
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
              l10n.vaultEmptyTitle,
              textAlign: TextAlign.center,
              style: AppTypography.bold.copyWith(
                fontSize: 20,
                color: AppColorsPalette.black,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.vaultEmptySubtitle,
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

  Widget _buildAlbumsGrid(BuildContext context) {
    final l10n = context.l10n;
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.78,
      children: [
        VaultAlbumCard(
          title: l10n.albumPhotos,
          subtitle: l10n.vaultAlbumItemsCount(photos.length),
          previewItems: photos.take(4).toList(),
          onTap: onOpenPhotos,
        ),
        VaultAlbumCard(
          title: l10n.albumVideos,
          subtitle: l10n.vaultAlbumItemsCount(videos.length),
          previewItems: videos.take(4).toList(),
          onTap: onOpenVideos,
        ),
      ],
    );
  }
}
