import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:applock/network/configuration/api_endpoint.dart';
import 'package:applock/network/configuration/retrofit_annotation.dart';
import 'package:applock/network/dto/ad_config_response_dto.dart';
import 'package:applock/network/dto/advertisement_response_dto.dart';

part 'ad_remote_data_source.g.dart';

@lazySingleton
@RestApi()
abstract class AdRemoteDataSource {
  @factoryMethod
  factory AdRemoteDataSource(@Named('hubDio') Dio dio) = _AdRemoteDataSource;

  @InjectHubQuery
  @GET(HubEndpoint.frequency)
  Future<AdConfigDto> getFullscreenAdFrequency();

  @InjectHubQuery
  @GET(HubEndpoint.ads)
  Future<AdvertisementDto> getCrossPromotionAd();

  @InjectHubBodyHostAppId
  @POST(HubEndpoint.adsEvent)
  Future<void> sendAdsEvent(@Body() Map<String, dynamic> requestBody);
}
