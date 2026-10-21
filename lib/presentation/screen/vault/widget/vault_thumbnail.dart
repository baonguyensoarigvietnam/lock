import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:applock/domain/model/vault_item.dart';
import 'package:applock/presentation/screen/vault/view_model/vault_view_model.dart';
import 'package:applock/presentation/theme/app_colors_palette.dart';

/// Thumbnail tile for a vault item. Photos are decrypted lazily in memory;
/// videos show a placeholder.
class VaultThumbnail extends StatefulWidget {
  final VaultItem item;
  final double iconSize;
  final BorderRadius borderRadius;

  const VaultThumbnail({
    super.key,
    required this.item,
    this.iconSize = 26,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  State<VaultThumbnail> createState() => _VaultThumbnailState();
}

class _VaultThumbnailState extends State<VaultThumbnail> {
  Future<Uint8List?>? _future;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(covariant VaultThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.id != widget.item.id) {
      _load();
    }
  }

  void _load() {
    _future = widget.item.isPhoto
        ? context.read<VaultViewModel>().loadThumbnail(widget.item)
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.borderRadius,
      child: widget.item.isVideo ? _buildVideoPlaceholder() : _buildPhoto(),
    );
  }

  Widget _buildPhoto() {
    return FutureBuilder<Uint8List?>(
      future: _future,
      builder: (context, snapshot) {
        final bytes = snapshot.data;
        if (bytes != null) {
          return Image.memory(
            bytes,
            fit: BoxFit.cover,
            gaplessPlayback: true,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (_, _, _) => _buildPhotoPlaceholder(),
          );
        }
        return _buildPhotoPlaceholder();
      },
    );
  }

  Widget _buildPhotoPlaceholder() {
    return Container(
      color: AppColorsPalette.gray150,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_outlined,
        size: widget.iconSize,
        color: AppColorsPalette.gray350,
      ),
    );
  }

  Widget _buildVideoPlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColorsPalette.gray700,
            AppColorsPalette.gray550,
            AppColorsPalette.gray900,
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.play_circle_outline_rounded,
        size: widget.iconSize,
        color: AppColorsPalette.white.withValues(alpha: 0.7),
      ),
    );
  }
}
