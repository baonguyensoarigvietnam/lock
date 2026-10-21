import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:applock/domain/model/intruder_alert.dart';
import 'package:applock/domain/repository/intruder_repository.dart';
import 'package:applock/utility/enumeration/intruder_unlock_method.dart';
import 'package:applock/utility/helper/result.dart';

@LazySingleton(as: IntruderRepository)
class IntruderRepositoryImpl implements IntruderRepository {
  IntruderRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const String _alertsKey = 'intruder_alerts';
  static const String _captureEnabledKey = 'intruder_capture_enabled';
  static const String _failedDateKey = 'intruder_failed_date';
  static const String _failedCountKey = 'intruder_failed_count';
  static const String _evidenceFolderName = 'AppLockEvidence';

  @override
  Future<Result<List<IntruderAlert>>> getAlerts() async {
    try {
      return Result.success(await _readAlerts());
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> addAlert(IntruderAlert alert) async {
    try {
      final alerts = await _readAlerts();
      alerts.insert(0, alert);
      await _writeAlerts(alerts);
      return const Result.success(null);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> deleteAlert(String id) async {
    try {
      final alerts = await _readAlerts();
      final removed = alerts.where((a) => a.id == id).toList();
      alerts.removeWhere((a) => a.id == id);
      await _writeAlerts(alerts);
      for (final alert in removed) {
        await _deletePhoto(alert.photoPath);
      }
      return const Result.success(null);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> clearAll() async {
    try {
      final alerts = await _readAlerts();
      await _prefs.remove(_alertsKey);
      for (final alert in alerts) {
        await _deletePhoto(alert.photoPath);
      }
      return const Result.success(null);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<String>> saveEvidence(IntruderAlert alert) async {
    try {
      final source = File(alert.photoPath ?? '');
      if (!alert.hasPhoto || !await source.exists()) {
        throw const FileSystemException('Photo not found');
      }
      Directory? baseDir;
      try {
        baseDir = await getExternalStorageDirectory();
      } catch (_) {
        baseDir = null;
      }
      baseDir ??= await getApplicationDocumentsDirectory();
      final targetDir = Directory('${baseDir.path}/$_evidenceFolderName');
      if (!await targetDir.exists()) {
        await targetDir.create(recursive: true);
      }
      final fileName = source.uri.pathSegments.last;
      final target = await source.copy('${targetDir.path}/$fileName');
      return Result.success(target.path);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> incrementTodayFailedCount() async {
    try {
      await _prefs.reload();
      final today = _todayKey();
      final storedDate = _prefs.getString(_failedDateKey);
      final current =
          storedDate == today ? (_prefs.getInt(_failedCountKey) ?? 0) : 0;
      await _prefs.setString(_failedDateKey, today);
      await _prefs.setInt(_failedCountKey, current + 1);
      return const Result.success(null);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<int>> getTodayFailedCount() async {
    try {
      await _prefs.reload();
      final storedDate = _prefs.getString(_failedDateKey);
      if (storedDate != _todayKey()) return const Result.success(0);
      return Result.success(_prefs.getInt(_failedCountKey) ?? 0);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<int>> getAlertCount() async {
    try {
      return Result.success((await _readAlerts()).length);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<bool>> isIntruderCaptureEnabled() async {
    try {
      await _prefs.reload();
      return Result.success(_prefs.getBool(_captureEnabledKey) ?? true);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> setIntruderCaptureEnabled(bool enabled) async {
    try {
      await _prefs.setBool(_captureEnabledKey, enabled);
      return const Result.success(null);
    } catch (e) {
      return Result.error(e);
    }
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// Reads alerts from storage. `reload()` keeps data in sync when alerts are
  /// written from another Flutter engine (e.g. the lock overlay).
  Future<List<IntruderAlert>> _readAlerts() async {
    await _prefs.reload();
    final raw = _prefs.getString(_alertsKey);
    if (raw == null || raw.isEmpty) return [];
    final decoded = jsonDecode(raw);
    if (decoded is! List) return [];
    final alerts = decoded
        .whereType<Map<String, dynamic>>()
        .map(_fromJson)
        .whereType<IntruderAlert>()
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return alerts;
  }

  Future<void> _writeAlerts(List<IntruderAlert> alerts) async {
    await _prefs.setString(
      _alertsKey,
      jsonEncode(alerts.map(_toJson).toList()),
    );
  }

  Future<void> _deletePhoto(String? path) async {
    if (path == null || path.isEmpty) return;
    try {
      final file = File(path);
      if (await file.exists()) await file.delete();
    } catch (_) {
      // Ignore file-system errors; the record itself is already removed.
    }
  }

  String _todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month}-${now.day}';
  }

  Map<String, dynamic> _toJson(IntruderAlert alert) => {
        'id': alert.id,
        'createdAt': alert.createdAt.millisecondsSinceEpoch,
        'appName': alert.appName,
        'method': alert.method.name,
        'failedCount': alert.failedCount,
        'photoPath': alert.photoPath,
      };

  IntruderAlert? _fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final createdAt = json['createdAt'];
    if (id is! String || createdAt is! int) return null;
    final methodName = json['method'] as String?;
    return IntruderAlert(
      id: id,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      appName: json['appName'] as String?,
      method: IntruderUnlockMethod.values.firstWhere(
        (m) => m.name == methodName,
        orElse: () => IntruderUnlockMethod.pin,
      ),
      failedCount: (json['failedCount'] as num?)?.toInt() ?? 0,
      photoPath: json['photoPath'] as String?,
    );
  }
}
