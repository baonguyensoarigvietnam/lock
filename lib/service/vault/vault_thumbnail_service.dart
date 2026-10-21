import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:injectable/injectable.dart';

/// Generates small PNG thumbnails for imported photos.
@lazySingleton
class VaultThumbnailService {
  VaultThumbnailService();

  static const int _thumbnailWidth = 320;

  /// Returns PNG thumbnail bytes for the image at [path], or `null` if the
  /// image could not be decoded.
  Future<Uint8List?> createPhotoThumbnail(String path) async {
    ui.Codec? codec;
    ui.Image? image;
    try {
      final bytes = await File(path).readAsBytes();
      final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
      final descriptor = await ui.ImageDescriptor.encoded(buffer);
      final targetWidth = descriptor.width > descriptor.height
          ? (_thumbnailWidth * descriptor.width / descriptor.height).round()
          : _thumbnailWidth;
      codec = await descriptor.instantiateCodec(
        targetWidth: descriptor.width < targetWidth
            ? descriptor.width
            : targetWidth,
      );
      final frame = await codec.getNextFrame();
      image = frame.image;
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      return data?.buffer.asUint8List();
    } catch (_) {
      return null;
    } finally {
      image?.dispose();
      codec?.dispose();
    }
  }
}
