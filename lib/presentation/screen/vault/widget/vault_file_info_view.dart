import 'package:flutter/material.dart';
import 'package:applock/domain/model/vault_item.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/screen/vault/widget/vault_format_helper.dart';
import 'package:applock/presentation/screen/vault/widget/vault_thumbnail.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class VaultFileInfoView extends StatelessWidget {
  final VaultItem item;
  final VoidCallback onBack;

  const VaultFileInfoView({
    super.key,
    required this.item,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        CommonAppBar.titledBack(
          onBack: onBack,
          title: l10n.fileInfoTitle,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // File Preview Box with overlapping "Protected" badge
                SizedBox(
                  height: 224,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 210,
                        decoration: BoxDecoration(
                          color: AppColorsPalette.gray150,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColorsPalette.gray200,
                            width: 1,
                          ),
                        ),
                        child: item.isPhoto
                            ? VaultThumbnail(
                                item: item,
                                iconSize: 48,
                                borderRadius: BorderRadius.circular(13),
                              )
                            : _buildFileIcon(),
                      ),
                      Positioned(
                        right: 16,
                        bottom: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: AppColorsPalette.black,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            l10n.protectedBadge,
                            style: AppTypography.bold.copyWith(
                              fontSize: 13,
                              color: AppColorsPalette.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Properties Section Title
                Text(
                  l10n.propertiesHeader,
                  style: AppTypography.bold.copyWith(
                    fontSize: 17,
                    color: AppColorsPalette.black,
                  ),
                ),
                const SizedBox(height: 12),

                // Properties Table Card
                Container(
                  decoration: BoxDecoration(
                    color: AppColorsPalette.gray50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: AppColorsPalette.gray200,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildPropertyRow(
                        icon: Icons.article_outlined,
                        label: l10n.propertyName,
                        value: item.nameWithoutExtension,
                      ),
                      _buildDivider(),
                      _buildPropertyRow(
                        icon: item.isVideo
                            ? Icons.movie_outlined
                            : Icons.image_outlined,
                        label: l10n.propertyType,
                        value: VaultFormatHelper.fileType(context, item),
                      ),
                      _buildDivider(),
                      _buildPropertyRow(
                        icon: Icons.storage_rounded,
                        label: l10n.propertySize,
                        value: VaultFormatHelper.fileSize(
                          context,
                          item.sizeBytes,
                        ),
                      ),
                      _buildDivider(),
                      _buildPropertyRow(
                        icon: Icons.calendar_today_outlined,
                        label: l10n.propertyImportedDate,
                        value: VaultFormatHelper.date(context, item.createdAt),
                      ),
                      _buildDivider(),
                      _buildPropertyRow(
                        icon: Icons.enhanced_encryption_outlined,
                        label: l10n.propertyEncryptionStatus,
                        value: l10n.vaultEncryptionAes256,
                        isHighlightedValue: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFileIcon() {
    return Center(
      child: SizedBox(
        width: 160,
        height: 110,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(
              Icons.insert_drive_file_outlined,
              size: 108,
              color: AppColorsPalette.gray250,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.movie_outlined,
                  size: 38,
                  color: AppColorsPalette.gray700,
                ),
                const SizedBox(height: 6),
                Text(
                  item.originalName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.medium.copyWith(
                    fontSize: 11,
                    color: AppColorsPalette.gray600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: AppColorsPalette.gray200,
    );
  }

  Widget _buildPropertyRow({
    required IconData icon,
    required String label,
    required String value,
    bool isHighlightedValue = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColorsPalette.gray600,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: AppTypography.regular.copyWith(
              fontSize: 14,
              color: AppColorsPalette.gray800,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: isHighlightedValue
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          value,
                          textAlign: TextAlign.end,
                          style: AppTypography.bold.copyWith(
                            fontSize: 14,
                            color: AppColorsPalette.black,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.verified_rounded,
                        size: 16,
                        color: AppColorsPalette.black,
                      ),
                    ],
                  )
                : Text(
                    value,
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.regular.copyWith(
                      fontSize: 14,
                      color: AppColorsPalette.gray600,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
