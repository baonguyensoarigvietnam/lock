import 'dart:typed_data';

import 'package:applock/domain/model/vault_item.dart';
import 'package:applock/utility/helper/result.dart';

abstract class VaultRepository {
  /// Maximum number of items a free (non-premium) user may store.
  static const int freePlanItemLimit = 100;

  /// Returns all vault items, newest first.
  Future<Result<List<VaultItem>>> getItems();

  /// Returns the number of items currently stored in the vault.
  Future<Result<int>> getItemCount();

  /// Emits the new item count every time items are imported or deleted.
  Stream<int> watchItemCount();

  /// Encrypts the file at [sourcePath] and adds it to the vault.
  ///
  /// Temporary picker copies (inside the app cache directory) are deleted
  /// after a successful import so that no plaintext copy is left behind.
  Future<Result<VaultItem>> importFile({
    required String sourcePath,
    required String originalName,
    required VaultMediaType type,
    String? album,
  });

  /// Decrypts the full item into memory.
  Future<Result<Uint8List>> readDecryptedBytes(String id);

  /// Decrypts the item's thumbnail into memory (photos only).
  Future<Result<Uint8List>> readThumbnailBytes(String id);

  /// Decrypts the item into a temporary file and returns its path.
  /// Callers must call [deleteTemporaryFile] when finished.
  Future<Result<String>> decryptToTemporaryFile(String id);

  /// Deletes a temporary decrypted file created by [decryptToTemporaryFile].
  Future<Result<void>> deleteTemporaryFile(String path);

  /// Permanently removes an item (encrypted file, thumbnail and index entry).
  Future<Result<void>> deleteItem(String id);
}
