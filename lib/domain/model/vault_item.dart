/// Type of media stored inside the encrypted vault.
enum VaultMediaType { photo, video }

/// A single encrypted item stored in the vault.
class VaultItem {
  const VaultItem({
    required this.id,
    required this.originalName,
    required this.type,
    required this.sizeBytes,
    required this.createdAt,
    required this.album,
    this.hasThumbnail = false,
  });

  final String id;
  final String originalName;
  final VaultMediaType type;

  /// Size of the original (decrypted) file in bytes.
  final int sizeBytes;

  /// Date the item was imported into the vault.
  final DateTime createdAt;

  /// Album identifier the item belongs to.
  final String album;

  /// Whether an encrypted thumbnail was generated for this item.
  final bool hasThumbnail;

  bool get isPhoto => type == VaultMediaType.photo;

  bool get isVideo => type == VaultMediaType.video;

  /// File name without its extension.
  String get nameWithoutExtension {
    final dot = originalName.lastIndexOf('.');
    return dot > 0 ? originalName.substring(0, dot) : originalName;
  }

  /// Upper-cased file extension (e.g. `JPG`), or empty if none.
  String get extension {
    final dot = originalName.lastIndexOf('.');
    if (dot < 0 || dot == originalName.length - 1) return '';
    return originalName.substring(dot + 1).toUpperCase();
  }
}

/// Default album identifiers.
abstract final class VaultAlbum {
  static const String photos = 'photos';
  static const String videos = 'videos';

  static String defaultFor(VaultMediaType type) =>
      type == VaultMediaType.photo ? photos : videos;
}
