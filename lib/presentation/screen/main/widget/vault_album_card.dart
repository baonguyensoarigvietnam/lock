import 'package:flutter/material.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';

class VaultAlbumCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int highlightedCellIndex;
  final VoidCallback onTap;

  const VaultAlbumCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.highlightedCellIndex = 2,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(10),
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
            // 2x2 Thumbnail Grid
            AspectRatio(
              aspectRatio: 1,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildMiniCell(
                            isHighlighted: highlightedCellIndex == 0,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: _buildMiniCell(
                            isHighlighted: highlightedCellIndex == 1,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildMiniCell(
                            isHighlighted: highlightedCellIndex == 2,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: _buildMiniCell(
                            isHighlighted: highlightedCellIndex == 3,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.bold.copyWith(
                          fontSize: 14,
                          color: AppColorsPalette.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: AppTypography.regular.copyWith(
                          fontSize: 11.5,
                          color: AppColorsPalette.gray500,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Icon(
                    Icons.lock_outline_rounded,
                    size: 16,
                    color: AppColorsPalette.gray500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiniCell({
    required bool isHighlighted,
    required BorderRadius borderRadius,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isHighlighted
            ? AppColorsPalette.gray350
            : AppColorsPalette.gray200,
        borderRadius: borderRadius,
      ),
    );
  }
}
