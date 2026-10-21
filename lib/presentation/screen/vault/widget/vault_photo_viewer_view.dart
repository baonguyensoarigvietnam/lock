import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:applock/presentation/common/widget/common_app_bar.dart';
import 'package:applock/presentation/screen/vault/widget/vault_viewer_bottom_bar.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';
import 'package:applock/presentation/theme/app_text_palette.dart';
import 'package:applock/utility/extension/build_context.dart';

class VaultPhotoViewerView extends StatelessWidget {
  final String fileName;

  /// Decrypted image bytes (kept in memory only).
  final Uint8List? imageBytes;
  final bool isLoading;
  final VoidCallback onBack;
  final VoidCallback onDelete;
  final VoidCallback onInfo;

  const VaultPhotoViewerView({
    super.key,
    required this.fileName,
    required this.imageBytes,
    required this.isLoading,
    required this.onBack,
    required this.onDelete,
    required this.onInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonAppBar.titledBack(
          onBack: onBack,
          title: fileName,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        const SizedBox(height: 16),

        // Main Image Canvas Preview
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColorsPalette.gray150,
                border: Border.all(
                  color: AppColorsPalette.gray200,
                  width: 1,
                ),
              ),
              child: _buildContent(context),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Bottom Action Toolbar (Delete | Info)
        VaultViewerBottomBar(
          onDeleteConfirmed: onDelete,
          onInfo: onInfo,
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    final bytes = imageBytes;
    if (bytes != null) {
      return InteractiveViewer(
        maxScale: 5,
        child: Center(
          child: Image.memory(
            bytes,
            fit: BoxFit.contain,
            gaplessPlayback: true,
            errorBuilder: (context, _, _) => _buildUnavailable(context),
          ),
        ),
      );
    }
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColorsPalette.black),
      );
    }
    return _buildUnavailable(context);
  }

  Widget _buildUnavailable(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.broken_image_outlined,
            size: 72,
            color: AppColorsPalette.gray350,
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.vaultPreviewUnavailable,
            style: AppTypography.medium.copyWith(
              fontSize: 13,
              color: AppColorsPalette.gray500,
            ),
          ),
        ],
      ),
    );
  }
}
