import 'package:json_annotation/json_annotation.dart';

part 'ad_config_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class AdConfigDto {
  const AdConfigDto({
    @JsonKey(name: 'fullscreen_ad_frequency')
    required this.fullscreenAdFrequency,
  });

  final int fullscreenAdFrequency;

  factory AdConfigDto.fromJson(Map<String, dynamic> json) =>
      _$AdConfigDtoFromJson(json);

  int toDomain() => fullscreenAdFrequency;
}
