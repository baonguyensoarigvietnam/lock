import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:applock/domain/model/intruder_alert.dart';
import 'package:applock/domain/repository/intruder_repository.dart';
import 'package:applock/service/permission/permission_service.dart';
import 'package:applock/utility/enumeration/intruder_unlock_method.dart';
import 'package:applock/utility/helper/result.dart';

/// Tracks consecutive failed unlock attempts and silently captures an
/// intruder selfie with the front camera once the threshold is reached.
@lazySingleton
class IntruderService {
  IntruderService(this._repository, this._permissionService);

  final IntruderRepository _repository;
  final PermissionService _permissionService;

  /// Number of consecutive failures that triggers an intruder alert.
  static const int failedAttemptsThreshold = 3;

  int _consecutiveFailures = 0;
  bool _isCapturing = false;

  /// Call on every failed unlock attempt.
  Future<void> recordFailedAttempt({
    String? appName,
    required IntruderUnlockMethod method,
  }) async {
    _consecutiveFailures++;
    await _repository.incrementTodayFailedCount();

    if (_consecutiveFailures < failedAttemptsThreshold || _isCapturing) return;

    final failedCount = _consecutiveFailures;
    _consecutiveFailures = 0;

    final enabledResult = await _repository.isIntruderCaptureEnabled();
    final enabled = enabledResult is Success<bool> ? enabledResult.data : true;
    if (!enabled) return;

    _isCapturing = true;
    try {
      String? photoPath;
      try {
        if (await _permissionService.isCameraPermissionGranted()) {
          photoPath = await _capturePhoto();
        }
      } catch (e) {
        debugPrint('IntruderService: capture failed: $e');
        photoPath = null;
      }

      final now = DateTime.now();
      await _repository.addAlert(
        IntruderAlert(
          id: now.microsecondsSinceEpoch.toString(),
          createdAt: now,
          appName: appName,
          method: method,
          failedCount: failedCount,
          photoPath: photoPath,
        ),
      );
    } finally {
      _isCapturing = false;
    }
  }

  /// Call on successful unlock.
  void resetFailedAttempts() {
    _consecutiveFailures = 0;
  }

  Future<String?> _capturePhoto() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return null;
    final frontCamera = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );
    if (frontCamera.lensDirection != CameraLensDirection.front) return null;

    final controller = CameraController(
      frontCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );
    try {
      await controller.initialize();
      final picture = await controller.takePicture();

      final supportDir = await getApplicationSupportDirectory();
      final intruderDir = Directory('${supportDir.path}/intruders');
      if (!await intruderDir.exists()) {
        await intruderDir.create(recursive: true);
      }
      final targetPath =
          '${intruderDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      await picture.saveTo(targetPath);
      try {
        final tmp = File(picture.path);
        if (tmp.path != targetPath && await tmp.exists()) await tmp.delete();
      } catch (_) {
        // Temp file cleanup is best-effort.
      }
      return targetPath;
    } finally {
      await controller.dispose();
    }
  }
}
