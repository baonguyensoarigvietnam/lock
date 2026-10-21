import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as crypto;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

/// AES-256-CBC file encryption for the vault.
///
/// Encrypted file layout: `[16-byte random IV][AES-CBC/PKCS7 ciphertext]`.
/// A random 256-bit key is generated once and kept in secure storage.
/// Heavy work runs on a background isolate to keep the UI responsive.
@lazySingleton
class VaultCryptoService {
  VaultCryptoService();

  static const String _keyStorageKey = 'vault_aes_256_key';
  static const int _keyLength = 32;
  static const int _ivLength = 16;

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Uint8List? _cachedKey;

  Future<Uint8List> _getOrCreateKey() async {
    final cached = _cachedKey;
    if (cached != null) return cached;

    final stored = await _secureStorage.read(key: _keyStorageKey);
    if (stored != null && stored.isNotEmpty) {
      final key = base64Decode(stored);
      if (key.length == _keyLength) {
        return _cachedKey = Uint8List.fromList(key);
      }
    }

    final key = crypto.Key.fromSecureRandom(_keyLength).bytes;
    await _secureStorage.write(key: _keyStorageKey, value: base64Encode(key));
    return _cachedKey = key;
  }

  /// Encrypts [plainBytes] in memory (used for small payloads like thumbnails).
  Future<Uint8List> encryptBytes(Uint8List plainBytes) async {
    final key = await _getOrCreateKey();
    return Isolate.run(() => _encrypt(key, plainBytes));
  }

  /// Encrypts the file at [sourcePath] and writes it to [destinationPath].
  Future<void> encryptFile({
    required String sourcePath,
    required String destinationPath,
  }) async {
    final key = await _getOrCreateKey();
    await Isolate.run(() async {
      final plain = await File(sourcePath).readAsBytes();
      final encrypted = _encrypt(key, plain);
      await File(destinationPath).writeAsBytes(encrypted, flush: true);
    });
  }

  /// Decrypts the encrypted file at [sourcePath] into memory.
  Future<Uint8List> decryptFile(String sourcePath) async {
    final key = await _getOrCreateKey();
    return Isolate.run(() async {
      final data = await File(sourcePath).readAsBytes();
      return _decrypt(key, data);
    });
  }

  /// Decrypts the encrypted file at [sourcePath] into [destinationPath].
  Future<void> decryptFileTo({
    required String sourcePath,
    required String destinationPath,
  }) async {
    final key = await _getOrCreateKey();
    await Isolate.run(() async {
      final data = await File(sourcePath).readAsBytes();
      final plain = _decrypt(key, data);
      await File(destinationPath).writeAsBytes(plain, flush: true);
    });
  }

  static Uint8List _encrypt(Uint8List key, Uint8List plain) {
    final iv = crypto.IV.fromSecureRandom(_ivLength);
    final encrypter = crypto.Encrypter(
      crypto.AES(crypto.Key(key), mode: crypto.AESMode.cbc),
    );
    final cipher = encrypter.encryptBytes(plain, iv: iv).bytes;
    final output = Uint8List(_ivLength + cipher.length)
      ..setRange(0, _ivLength, iv.bytes)
      ..setRange(_ivLength, _ivLength + cipher.length, cipher);
    return output;
  }

  static Uint8List _decrypt(Uint8List key, Uint8List data) {
    if (data.length <= _ivLength) {
      throw const FormatException('Encrypted vault file is corrupted');
    }
    final iv = crypto.IV(Uint8List.sublistView(data, 0, _ivLength));
    final cipher = crypto.Encrypted(Uint8List.sublistView(data, _ivLength));
    final encrypter = crypto.Encrypter(
      crypto.AES(crypto.Key(key), mode: crypto.AESMode.cbc),
    );
    return Uint8List.fromList(encrypter.decryptBytes(cipher, iv: iv));
  }
}
