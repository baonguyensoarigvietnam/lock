import 'dart:typed_data';

import 'package:applock/domain/model/vault_item.dart';
import 'package:applock/presentation/common/base/base_view_model.dart';
import 'package:applock/utility/enumeration/vault_step.dart';
import 'package:applock/utility/enumeration/view_status.dart';
import 'package:applock/utility/helper/nullable.dart';

class VaultState extends BaseState {
  final bool hasLoaded;
  final List<VaultItem> items;
  final VaultStep currentStep;

  /// Step to return to from the import flow.
  final VaultStep previousStepBeforeImport;

  /// Viewer step to return to from the file info screen.
  final VaultStep previousViewerStep;

  /// Media type of the current/last import.
  final VaultMediaType importType;
  final int importTotal;
  final int importProcessed;
  final int importedCount;

  final VaultItem? selectedItem;
  final Uint8List? viewerPhotoBytes;
  final String? viewerVideoPath;
  final bool isViewerLoading;

  /// Incremented every time the free plan limit blocks an import.
  final int limitReachedEvent;

  /// Incremented every time an operation fails.
  final int failureEvent;

  const VaultState({
    super.status = ViewStatus.initial,
    super.errorMessage,
    this.hasLoaded = false,
    this.items = const [],
    this.currentStep = VaultStep.empty,
    this.previousStepBeforeImport = VaultStep.albums,
    this.previousViewerStep = VaultStep.photoViewer,
    this.importType = VaultMediaType.photo,
    this.importTotal = 0,
    this.importProcessed = 0,
    this.importedCount = 0,
    this.selectedItem,
    this.viewerPhotoBytes,
    this.viewerVideoPath,
    this.isViewerLoading = false,
    this.limitReachedEvent = 0,
    this.failureEvent = 0,
  });

  List<VaultItem> get photos => items.where((e) => e.isPhoto).toList();

  List<VaultItem> get videos => items.where((e) => e.isVideo).toList();

  int get itemCount => items.length;

  @override
  VaultState copyWith({
    ViewStatus? status,
    Nullable<String>? errorMessage,
    bool? hasLoaded,
    List<VaultItem>? items,
    VaultStep? currentStep,
    VaultStep? previousStepBeforeImport,
    VaultStep? previousViewerStep,
    VaultMediaType? importType,
    int? importTotal,
    int? importProcessed,
    int? importedCount,
    Nullable<VaultItem>? selectedItem,
    Nullable<Uint8List>? viewerPhotoBytes,
    Nullable<String>? viewerVideoPath,
    bool? isViewerLoading,
    int? limitReachedEvent,
    int? failureEvent,
  }) {
    return VaultState(
      status: status ?? this.status,
      errorMessage:
          errorMessage != null ? errorMessage.value : this.errorMessage,
      hasLoaded: hasLoaded ?? this.hasLoaded,
      items: items ?? this.items,
      currentStep: currentStep ?? this.currentStep,
      previousStepBeforeImport:
          previousStepBeforeImport ?? this.previousStepBeforeImport,
      previousViewerStep: previousViewerStep ?? this.previousViewerStep,
      importType: importType ?? this.importType,
      importTotal: importTotal ?? this.importTotal,
      importProcessed: importProcessed ?? this.importProcessed,
      importedCount: importedCount ?? this.importedCount,
      selectedItem:
          selectedItem != null ? selectedItem.value : this.selectedItem,
      viewerPhotoBytes: viewerPhotoBytes != null
          ? viewerPhotoBytes.value
          : this.viewerPhotoBytes,
      viewerVideoPath:
          viewerVideoPath != null ? viewerVideoPath.value : this.viewerVideoPath,
      isViewerLoading: isViewerLoading ?? this.isViewerLoading,
      limitReachedEvent: limitReachedEvent ?? this.limitReachedEvent,
      failureEvent: failureEvent ?? this.failureEvent,
    );
  }
}
