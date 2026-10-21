import 'package:applock/domain/model/vault_item.dart';

/// JSON representation of a [VaultItem] stored in the vault index file.
class VaultItemDto {
  const VaultItemDto({
    required this.id,
    required this.originalName,
    required this.type,
    required this.sizeBytes,
    required this.createdAt,
    required this.album,
    required this.hasThumbnail,
  });

  final String id;
  final String originalName;
  final String type;
  final int sizeBytes;
  final int createdAt;
  final String album;
  final bool hasThumbnail;

  factory VaultItemDto.fromJson(Map<String, dynamic> json) {
    return VaultItemDto(
      id: json['id'] as String,
      originalName: json['originalName'] as String? ?? '',
      type: json['type'] as String? ?? VaultMediaType.photo.name,
      sizeBytes: (json['size'] as num?)?.toInt() ?? 0,
      createdAt: (json['createdAt'] as num?)?.toInt() ?? 0,
      album: json['album'] as String? ?? VaultAlbum.photos,
      hasThumbnail: json['hasThumbnail'] as bool? ?? false,
    );
  }

  factory VaultItemDto.fromDomain(VaultItem item) {
    return VaultItemDto(
      id: item.id,
      originalName: item.originalName,
      type: item.type.name,
      sizeBytes: item.sizeBytes,
      createdAt: item.createdAt.millisecondsSinceEpoch,
      album: item.album,
      hasThumbnail: item.hasThumbnail,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'originalName': originalName,
        'type': type,
        'size': sizeBytes,
        'createdAt': createdAt,
        'album': album,
        'hasThumbnail': hasThumbnail,
      };

  VaultItem toDomain() {
    return VaultItem(
      id: id,
      originalName: originalName,
      type: type == VaultMediaType.video.name
          ? VaultMediaType.video
          : VaultMediaType.photo,
      sizeBytes: sizeBytes,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      album: album,
      hasThumbnail: hasThumbnail,
    );
  }
}
