import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:applock/local/dto/vault_item_dto.dart';

/// File-system access for the vault: encrypted files and the JSON index.
///
/// Layout (inside `getApplicationSupportDirectory()`):
/// ```
/// vault/
///   index.json
///   <id>.enc        encrypted original
///   <id>.thumb.enc  encrypted thumbnail (photos)
/// ```
@lazySingleton
class VaultLocalDataSource {
  VaultLocalDataSource();

  static const String _vaultFolder = 'vault';
  static const String _tempFolder = 'vault_tmp';
  static const String _indexFileName = 'index.json';

  Directory? _vaultDirectory;
  List<VaultItemDto>? _cache;

  Future<Directory> vaultDirectory() async {
    final cached = _vaultDirectory;
    if (cached != null) return cached;
    final support = await getApplicationSupportDirectory();
    final dir = Directory('${support.path}/$_vaultFolder');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return _vaultDirectory = dir;
  }

  Future<Directory> temporaryDirectory() async {
    final tmp = await getTemporaryDirectory();
    final dir = Directory('${tmp.path}/$_tempFolder');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  /// Root of the app's cache directory (where picker copies are placed).
  Future<String> cacheRootPath() async =>
      (await getTemporaryDirectory()).path;

  Future<String> encryptedFilePath(String id) async =>
      '${(await vaultDirectory()).path}/$id.enc';

  Future<String> thumbnailFilePath(String id) async =>
      '${(await vaultDirectory()).path}/$id.thumb.enc';

  Future<File> _indexFile() async =>
      File('${(await vaultDirectory()).path}/$_indexFileName');

  Future<List<VaultItemDto>> readIndex() async {
    final cached = _cache;
    if (cached != null) return List.of(cached);

    final file = await _indexFile();
    if (!await file.exists()) {
      _cache = [];
      return [];
    }
    final raw = await file.readAsString();
    if (raw.trim().isEmpty) {
      _cache = [];
      return [];
    }
    final decoded = jsonDecode(raw) as List<dynamic>;
    final items = decoded
        .whereType<Map<String, dynamic>>()
        .map(VaultItemDto.fromJson)
        .toList();
    _cache = items;
    return List.of(items);
  }

  Future<void> writeIndex(List<VaultItemDto> items) async {
    final file = await _indexFile();
    final tmp = File('${file.path}.tmp');
    await tmp.writeAsString(
      jsonEncode(items.map((e) => e.toJson()).toList()),
      flush: true,
    );
    await tmp.rename(file.path);
    _cache = List.of(items);
  }

  Future<void> deleteIfExists(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
