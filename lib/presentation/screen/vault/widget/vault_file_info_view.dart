import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_subpage_app_bar.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class VaultFileInfoView extends StatelessWidget {
  final String fileName;
  final String fileNameWithoutExtension;
  final String fileType;
  final String fileSize;
  final String importedDate;
  final VoidCallback onBack;

  const VaultFileInfoView({
    super.key,
    this.fileName = 'IMG_20240315.jpg',
    this.fileNameWithoutExtension = 'IMG_20240315',
    this.fileType = 'JPG',
    this.fileSize = '4.2 MB',
    this.importedDate = 'Oct 24, 2023',
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonSubpageAppBar(
          onBack: onBack,
          title: 'File info',
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
                        child: Center(
                          child: SizedBox(
                            width: 120,
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
                                      Icons.image_outlined,
                                      size: 38,
                                      color: AppColorsPalette.gray700,
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      fileName,
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
                        ),
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
                            'Protected',
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
                  'Properties',
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
                        label: 'Name',
                        value: fileNameWithoutExtension,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColorsPalette.gray200,
                      ),
                      _buildPropertyRow(
                        icon: Icons.article_outlined,
                        label: 'Type',
                        value: fileType,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColorsPalette.gray200,
                      ),
                      _buildPropertyRow(
                        icon: Icons.storage_rounded,
                        label: 'Size',
                        value: fileSize,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColorsPalette.gray200,
                      ),
                      _buildPropertyRow(
                        icon: Icons.calendar_today_outlined,
                        label: 'Imported date',
                        value: importedDate,
                      ),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColorsPalette.gray200,
                      ),
                      _buildPropertyRow(
                        icon: Icons.enhanced_encryption_outlined,
                        label: 'Encryption status',
                        value: 'AES-256',
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
          const Spacer(),
          if (isHighlightedValue)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: AppTypography.bold.copyWith(
                    fontSize: 14,
                    color: AppColorsPalette.black,
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
          else
            Text(
              value,
              style: AppTypography.regular.copyWith(
                fontSize: 14,
                color: AppColorsPalette.gray600,
              ),
            ),
        ],
      ),
    );
  }
}
