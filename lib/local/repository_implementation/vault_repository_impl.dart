import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:applock/domain/model/vault_item.dart';
import 'package:applock/domain/repository/vault_repository.dart';
import 'package:applock/local/data_source/vault_local_data_source.dart';
import 'package:applock/local/dto/vault_item_dto.dart';
import 'package:applock/service/vault/vault_crypto_service.dart';
import 'package:applock/service/vault/vault_thumbnail_service.dart';
import 'package:applock/utility/helper/result.dart';

@LazySingleton(as: VaultRepository)
class VaultRepositoryImpl implements VaultRepository {
  VaultRepositoryImpl(
    this._localDataSource,
    this._cryptoService,
    this._thumbnailService,
  );

  final VaultLocalDataSource _localDataSource;
  final VaultCryptoService _cryptoService;
  final VaultThumbnailService _thumbnailService;

  final StreamController<int> _countController =
      StreamController<int>.broadcast();
  final Random _random = Random.secure();

  /// Serializes index mutations so concurrent writes never clobber each other.
  Future<void> _indexLock = Future.value();

  Future<T> _synchronized<T>(Future<T> Function() action) {
    final completer = Completer<T>();
    _indexLock = _indexLock.then((_) async {
      try {
        completer.complete(await action());
      } catch (e, s) {
        completer.completeError(e, s);
      }
    });
    return completer.future;
  }

  String _generateId() {
    final time = DateTime.now().microsecondsSinceEpoch.toRadixString(16);
    final rand = List.generate(
      8,
      (_) => _random.nextInt(256).toRadixString(16).padLeft(2, '0'),
    ).join();
    return '$time$rand';
  }

  Future<VaultItemDto?> _findDto(String id) async {
    final items = await _localDataSource.readIndex();
    for (final item in items) {
      if (item.id == id) return item;
    }
    return null;
  }

  @override
  Future<Result<List<VaultItem>>> getItems() async {
    try {
      final items = await _localDataSource.readIndex();
      final domain = items.map((e) => e.toDomain()).toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return Result.success(domain);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<int>> getItemCount() async {
    try {
      final items = await _localDataSource.readIndex();
      return Result.success(items.length);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Stream<int> watchItemCount() => _countController.stream;

  @override
  Future<Result<VaultItem>> importFile({
    required String sourcePath,
    required String originalName,
    required VaultMediaType type,
    String? album,
  }) async {
    final id = _generateId();
    String? encryptedPath;
    String? thumbnailPath;
    try {
      final source = File(sourcePath);
      final size = await source.length();
      encryptedPath = await _localDataSource.encryptedFilePath(id);

      await _cryptoService.encryptFile(
        sourcePath: sourcePath,
        destinationPath: encryptedPath,
      );

      var hasThumbnail = false;
      if (type == VaultMediaType.photo) {
        final thumb = await _thumbnailService.createPhotoThumbnail(sourcePath);
        if (thumb != null) {
          thumbnailPath = await _localDataSource.thumbnailFilePath(id);
          final encryptedThumb = await _cryptoService.encryptBytes(thumb);
          await File(thumbnailPath).writeAsBytes(encryptedThumb, flush: true);
          hasThumbnail = true;
        }
      }

      final item = VaultItem(
        id: id,
        originalName: originalName,
        type: type,
        sizeBytes: size,
        createdAt: DateTime.now(),
        album: album ?? VaultAlbum.defaultFor(type),
        hasThumbnail: hasThumbnail,
      );

      final count = await _synchronized(() async {
        final items = await _localDataSource.readIndex();
        items.add(VaultItemDto.fromDomain(item));
        await _localDataSource.writeIndex(items);
        return items.length;
      });
      _countController.add(count);

      await _deletePickerCopy(sourcePath);
      return Result.success(item);
    } catch (e) {
      // Roll back partially written files.
      if (encryptedPath != null) {
        await _safeDelete(encryptedPath);
      }
      if (thumbnailPath != null) {
        await _safeDelete(thumbnailPath);
      }
      return Result.error(e);
    }
  }

  /// Picker copies live in the app cache; remove them so no plaintext copy
  /// stays on disk. Files outside the cache are never touched.
  Future<void> _deletePickerCopy(String sourcePath) async {
    try {
      final cacheRoot = await _localDataSource.cacheRootPath();
      if (sourcePath.startsWith(cacheRoot)) {
        await _localDataSource.deleteIfExists(sourcePath);
      }
    } catch (_) {
      // Best effort only.
    }
  }

  Future<void> _safeDelete(String path) async {
    try {
      await _localDataSource.deleteIfExists(path);
    } catch (_) {
      // Best effort only.
    }
  }

  @override
  Future<Result<Uint8List>> readDecryptedBytes(String id) async {
    try {
      final path = await _localDataSource.encryptedFilePath(id);
      return Result.success(await _cryptoService.decryptFile(path));
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<Uint8List>> readThumbnailBytes(String id) async {
    try {
      final path = await _localDataSource.thumbnailFilePath(id);
      if (!await File(path).exists()) {
        return Result.error(Exception('Thumbnail not found'));
      }
      return Result.success(await _cryptoService.decryptFile(path));
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<String>> decryptToTemporaryFile(String id) async {
    try {
      final dto = await _findDto(id);
      if (dto == null) {
        return Result.error(Exception('Vault item not found'));
      }
      final tempDir = await _localDataSource.temporaryDirectory();
      // Remove leftovers from previous sessions (e.g. after a crash).
      await for (final entity in tempDir.list()) {
        if (entity is File) {
          await _safeDelete(entity.path);
        }
      }
      final item = dto.toDomain();
      final ext = item.extension.isEmpty ? 'mp4' : item.extension.toLowerCase();
      final destination = '${tempDir.path}/${_generateId()}.$ext';
      await _cryptoService.decryptFileTo(
        sourcePath: await _localDataSource.encryptedFilePath(id),
        destinationPath: destination,
      );
      return Result.success(destination);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> deleteTemporaryFile(String path) async {
    try {
      final tempDir = await _localDataSource.temporaryDirectory();
      if (path.startsWith(tempDir.path)) {
        await _localDataSource.deleteIfExists(path);
      }
      return const Result.success(null);
    } catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<void>> deleteItem(String id) async {
    try {
      final count = await _synchronized(() async {
        final items = await _localDataSource.readIndex();
        items.removeWhere((e) => e.id == id);
        await _localDataSource.writeIndex(items);
        return items.length;
      });
      await _safeDelete(await _localDataSource.encryptedFilePath(id));
      await _safeDelete(await _localDataSource.thumbnailFilePath(id));
      _countController.add(count);
      return const Result.success(null);
    } catch (e) {
      return Result.error(e);
    }
  }
}
