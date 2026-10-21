import 'package:json_annotation/json_annotation.dart';
import 'package:applock/domain/model/advertisement.dart';

part 'advertisement_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class AdvertisementDto {
  const AdvertisementDto({
    required this.appId,
    required this.headline,
    required this.imageUrl,
    required this.storeUrl,
  });

  @JsonKey(name: 'app_id')
  final String appId;

  @JsonKey(name: 'headline')
  final String headline;

  @JsonKey(name: 'promotion_image')
  final String imageUrl;

  @JsonKey(name: 'store_url')
  final String storeUrl;

  factory AdvertisementDto.fromJson(Map<String, dynamic> json) =>
      _$AdvertisementDtoFromJson(json);

  Advertisement toDomain() {
    return Advertisement(
      appId: appId,
      headline: headline,
      imageUrl: imageUrl,
      storeUrl: storeUrl,
    );
  }
}
