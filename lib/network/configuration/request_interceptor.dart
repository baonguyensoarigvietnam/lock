import 'dart:io' show Platform;

import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:applock/network/configuration/network_configuration.dart';
import 'package:applock/network/utility/constant/network_constant.dart';

/// Injects Central Hub API key and app metadata into outgoing requests.
class RequestInterceptor extends Interceptor {
  RequestInterceptor({
    required this.packageInfo,
  });

  final PackageInfo packageInfo;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_shouldSkipAuth(options)) {
      return handler.next(options);
    }

    _injectApiKey(options);
    _injectMetadata(options);

    return handler.next(options);
  }

  bool _shouldSkipAuth(RequestOptions options) {
    return options.extra[NetworkConstant.skipAuthApi] == true;
  }

  void _injectApiKey(RequestOptions options) {
    final apiKey = NetworkConfiguration.hubApiKey;
    if (apiKey.isEmpty) return;
    options.headers[NetworkConstant.apiKeyHeader] = apiKey;
  }

  void _injectMetadata(RequestOptions options) {
    final shouldInjectQuery =
        options.extra[NetworkConstant.injectHubQuery] == true;
    final bodyKey = _resolveBodyKey(options);

    if (!shouldInjectQuery && bodyKey == null) {
      return;
    }

    final appId = packageInfo.packageName;
    final platform = Platform.isIOS
        ? NetworkConstant.platformIOS
        : NetworkConstant.platformAndroid;

    final metadata = <String, dynamic>{NetworkConstant.platformKey: platform};

    if (shouldInjectQuery) {
      options.queryParameters.addAll({
        NetworkConstant.appIdKey: appId,
        ...metadata,
      });
    }

    if (bodyKey != null) {
      final bodyData = {bodyKey: appId, ...metadata};
      final requestData = options.data;

      if (requestData is Map<String, dynamic>) {
        requestData.addAll(bodyData);
      } else if (requestData == null) {
        options.data = bodyData;
      }
    }
  }

  String? _resolveBodyKey(RequestOptions options) {
    if (options.extra[NetworkConstant.injectHubBodyHostAppId] == true) {
      return NetworkConstant.hostAppIdKey;
    }

    if (options.extra[NetworkConstant.injectHubBodyAppId] == true) {
      return NetworkConstant.appIdKey;
    }

    return null;
  }
}
