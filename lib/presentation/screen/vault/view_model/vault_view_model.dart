import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:applock/domain/model/vault_item.dart';
import 'package:applock/domain/repository/vault_repository.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/presentation/screen/vault/view_model/vault_state.dart';
import 'package:applock/service/vault/vault_media_picker_service.dart';
import 'package:applock/utility/enumeration/vault_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';
import 'package:applock/utility/helper/result.dart';

@injectable
class VaultViewModel extends BaseCubit<VaultState> {
  VaultViewModel(this._repository, this._pickerService)
      : super(const VaultState());

  final VaultRepository _repository;
  final VaultMediaPickerService _pickerService;

  static const int _thumbnailCacheSize = 120;
  final LinkedHashMap<String, Uint8List> _thumbnailCache = LinkedHashMap();
  bool _isImporting = false;

  VaultStep get _overviewStep =>
      state.items.isEmpty ? VaultStep.empty : VaultStep.albums;

  Future<void> loadItems() async {
    await handleCallData<List<VaultItem>>(
      apiCall: _repository.getItems(),
      showLoading: !state.hasLoaded,
      onSuccess: (items) {
        final isOverview = state.currentStep == VaultStep.empty ||
            state.currentStep == VaultStep.albums;
        emit(state.copyWith(
          status: ViewStatus.success,
          hasLoaded: true,
          items: items,
          currentStep: isOverview
              ? (items.isEmpty ? VaultStep.empty : VaultStep.albums)
              : null,
        ));
      },
      onError: (_, message, _) {
        emit(state.copyWith(
          status: ViewStatus.failure,
          hasLoaded: true,
          errorMessage: Nullable(message),
          failureEvent: state.failureEvent + 1,
        ));
      },
    );
  }

  void setStep(VaultStep step) {
    emit(state.copyWith(currentStep: step));
  }

  void goToOverview() => setStep(_overviewStep);

  /// Opens the system picker for [type], then encrypts the chosen files.
  Future<void> importMedia({
    required VaultMediaType type,
    required bool isPremium,
  }) async {
    if (_isImporting) return;

    int? remaining;
    if (!isPremium) {
      remaining = VaultRepository.freePlanItemLimit - state.itemCount;
      if (remaining <= 0) {
        emit(state.copyWith(limitReachedEvent: state.limitReachedEvent + 1));
        return;
      }
    }

    _isImporting = true;
    try {
      final List<PickedVaultMedia> picked;
      try {
        picked = type == VaultMediaType.photo
            ? await _pickerService.pickPhotos(limit: remaining)
            : await _pickerService.pickVideos(limit: remaining);
      } catch (e) {
        emit(state.copyWith(failureEvent: state.failureEvent + 1));
        return;
      }
      if (picked.isEmpty || isClosed) return;

      var toImport = picked;
      var limitHit = false;
      if (remaining != null && picked.length > remaining) {
        toImport = picked.sublist(0, remaining);
        limitHit = true;
      }

      final previousStep = state.currentStep;
      emit(state.copyWith(
        previousStepBeforeImport: previousStep,
        importType: type,
        importTotal: toImport.length,
        importProcessed: 0,
        importedCount: 0,
        currentStep: VaultStep.encrypting,
      ));

      var imported = 0;
      for (var i = 0; i < toImport.length; i++) {
        final media = toImport[i];
        final result = await _repository.importFile(
          sourcePath: media.path,
          originalName: media.name,
          type: type,
        );
        if (result is Success<VaultItem>) imported++;
        if (isClosed) return;
        emit(state.copyWith(importProcessed: i + 1, importedCount: imported));
      }

      final itemsResult = await _repository.getItems();
      if (isClosed) return;
      final items = itemsResult is Success<List<VaultItem>>
          ? itemsResult.data
          : state.items;

      if (imported == 0) {
        emit(state.copyWith(
          items: items,
          currentStep: previousStep,
          failureEvent: state.failureEvent + 1,
        ));
        return;
      }

      emit(state.copyWith(
        items: items,
        // Apps cannot silently delete gallery originals without extra
        // permissions, so the user is always asked to delete them manually.
        currentStep: VaultStep.importCompleteManualDelete,
        failureEvent:
            imported < toImport.length ? state.failureEvent + 1 : null,
        limitReachedEvent: limitHit ? state.limitReachedEvent + 1 : null,
      ));
    } finally {
      _isImporting = false;
    }
  }

  void viewVaultAfterImport() {
    setStep(state.importType == VaultMediaType.video
        ? VaultStep.videosDetail
        : VaultStep.photosDetail);
  }

  /// Returns a decrypted thumbnail for a photo (cached in memory).
  Future<Uint8List?> loadThumbnail(VaultItem item) async {
    final cached = _thumbnailCache.remove(item.id);
    if (cached != null) {
      _thumbnailCache[item.id] = cached;
      return cached;
    }
    final Result<Uint8List> result = item.hasThumbnail
        ? await _repository.readThumbnailBytes(item.id)
        : await _repository.readDecryptedBytes(item.id);
    if (result is! Success<Uint8List>) return null;
    if (item.hasThumbnail) {
      _thumbnailCache[item.id] = result.data;
      if (_thumbnailCache.length > _thumbnailCacheSize) {
        _thumbnailCache.remove(_thumbnailCache.keys.first);
      }
    }
    return result.data;
  }

  Future<void> openPhotoViewer(VaultItem item) async {
    emit(state.copyWith(
      selectedItem: Nullable(item),
      viewerPhotoBytes: const Nullable(null),
      isViewerLoading: true,
      currentStep: VaultStep.photoViewer,
    ));
    final result = await _repository.readDecryptedBytes(item.id);
    if (isClosed || state.selectedItem?.id != item.id) return;
    switch (result) {
      case Success(data: final bytes):
        emit(state.copyWith(
          viewerPhotoBytes: Nullable(bytes),
          isViewerLoading: false,
        ));
      case Error():
        emit(state.copyWith(
          isViewerLoading: false,
          failureEvent: state.failureEvent + 1,
        ));
    }
  }

  Future<void> openVideoViewer(VaultItem item) async {
    emit(state.copyWith(
      selectedItem: Nullable(item),
      viewerVideoPath: const Nullable(null),
      isViewerLoading: true,
      currentStep: VaultStep.videoViewer,
    ));
    final result = await _repository.decryptToTemporaryFile(item.id);
    if (isClosed) {
      if (result is Success<String>) {
        unawaited(_repository.deleteTemporaryFile(result.data));
      }
      return;
    }
    if (state.selectedItem?.id != item.id ||
        state.currentStep != VaultStep.videoViewer) {
      if (result is Success<String>) {
        unawaited(_repository.deleteTemporaryFile(result.data));
      }
      return;
    }
    switch (result) {
      case Success(data: final path):
        emit(state.copyWith(
          viewerVideoPath: Nullable(path),
          isViewerLoading: false,
        ));
      case Error():
        emit(state.copyWith(
          isViewerLoading: false,
          failureEvent: state.failureEvent + 1,
        ));
    }
  }

  /// Deletes the decrypted temporary video file. Called by the video viewer
  /// when it is disposed (no state is emitted because the widget tree is
  /// locked during dispose).
  void releaseVideoTempFile(String path) {
    unawaited(_repository.deleteTemporaryFile(path));
  }

  void openFileInfo() {
    emit(state.copyWith(
      previousViewerStep: state.currentStep,
      currentStep: VaultStep.fileInfo,
    ));
  }

  void closeFileInfo() {
    final item = state.selectedItem;
    if (state.previousViewerStep == VaultStep.videoViewer && item != null) {
      // The temporary decrypted copy was removed when the player closed.
      openVideoViewer(item);
      return;
    }
    setStep(state.previousViewerStep);
  }

  void closeViewer() {
    final item = state.selectedItem;
    emit(state.copyWith(
      currentStep: item?.isVideo == true
          ? VaultStep.videosDetail
          : VaultStep.photosDetail,
      viewerPhotoBytes: const Nullable(null),
      viewerVideoPath: const Nullable(null),
      isViewerLoading: false,
    ));
  }

  Future<void> deleteSelectedItem() async {
    final item = state.selectedItem;
    if (item == null) return;
    final result = await _repository.deleteItem(item.id);
    if (isClosed) return;
    switch (result) {
      case Success():
        _thumbnailCache.remove(item.id);
        final items = state.items.where((e) => e.id != item.id).toList();
        emit(state.copyWith(
          items: items,
          selectedItem: const Nullable(null),
          viewerPhotoBytes: const Nullable(null),
          viewerVideoPath: const Nullable(null),
          currentStep:
              item.isVideo ? VaultStep.videosDetail : VaultStep.photosDetail,
        ));
      case Error():
        emit(state.copyWith(failureEvent: state.failureEvent + 1));
    }
  }
}
