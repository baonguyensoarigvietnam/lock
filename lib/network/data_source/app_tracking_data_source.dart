import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:applock/network/configuration/api_endpoint.dart';
import 'package:applock/network/configuration/retrofit_annotation.dart';

part 'app_tracking_data_source.g.dart';

@lazySingleton
@RestApi()
abstract class AppTrackingDataSource {
  @factoryMethod
  factory AppTrackingDataSource(@Named('hubDio') Dio dio) =
      _AppTrackingDataSource;

  @InjectHubBodyAppId
  @InjectDeviceUuidBody
  @POST(HubEndpoint.installs)
  Future<void> trackInstall(@Body() Map<String, dynamic> requestBody);
}
