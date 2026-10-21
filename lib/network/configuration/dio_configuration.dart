import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:applock/network/configuration/api_endpoint.dart';
import 'package:applock/network/configuration/request_interceptor.dart';
import 'package:applock/network/configuration/response_interceptor.dart';

@singleton
final class DioConfiguration {
  DioConfiguration(this._packageInfo);

  final PackageInfo _packageInfo;

  /// Dio for the central Hub services (Ads, Frequency, Cross-Promotion)
  Dio getHubDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: HubEndpoint.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 10),
        contentType: Headers.jsonContentType,
      ),
    );

    dio.interceptors.addAll([
      RequestInterceptor(packageInfo: _packageInfo),
      const ResponseInterceptor(),
      LogInterceptor(
        error: true,
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ),
    ]);

    return dio;
  }
}
