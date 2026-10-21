import 'dart:io';

import 'package:image_picker/image_picker.dart';
// Needed to opt into the Android Photo Picker.
import 'package:image_picker_android/image_picker_android.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart'
    show ImagePickerPlatform;
import 'package:injectable/injectable.dart';

/// A media file selected through the system picker.
class PickedVaultMedia {
  const PickedVaultMedia({required this.path, required this.name});

  final String path;
  final String name;
}

/// Wraps `image_picker` so the vault uses the Android Photo Picker, which
/// grants access only to the selected items and needs no storage /
/// READ_MEDIA_* permission.
@lazySingleton
class VaultMediaPickerService {
  VaultMediaPickerService() {
    _enableAndroidPhotoPicker();
  }

  final ImagePicker _picker = ImagePicker();

  /// Opens the system picker for multiple photos.
  Future<List<PickedVaultMedia>> pickPhotos({int? limit}) async {
    final files = await _picker.pickMultiImage(
      requestFullMetadata: false,
      limit: limit != null && limit >= 2 ? limit : null,
    );
    return _map(files);
  }

  /// Opens the system picker for multiple videos.
  Future<List<PickedVaultMedia>> pickVideos({int? limit}) async {
    final files = await _picker.pickMultiVideo(
      limit: limit != null && limit >= 2 ? limit : null,
    );
    return _map(files);
  }

  List<PickedVaultMedia> _map(List<XFile> files) => files
      .map((file) => PickedVaultMedia(path: file.path, name: file.name))
      .toList();

  /// `image_picker_android` falls back to ACTION_GET_CONTENT (below API 36)
  /// unless `useAndroidPhotoPicker` is enabled. Neither path needs storage
  /// permissions, but the Photo Picker gives the best privacy UX.
  void _enableAndroidPhotoPicker() {
    if (!Platform.isAndroid) return;
    final platform = ImagePickerPlatform.instance;
    if (platform is ImagePickerAndroid) {
      platform.useAndroidPhotoPicker = true;
    }
  }
}
