import 'package:dio/dio.dart';
import 'package:applock/network/utility/constant/network_constant.dart';
import 'package:applock/network/utility/extension/http_response_extension.dart';
import 'package:applock/network/utility/helper/network_response.dart';

/// Normalizes API response envelopes.
class ResponseInterceptor extends Interceptor {
  const ResponseInterceptor();

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (response.shouldSkipEnvelope) {
      handler.next(response);
      return;
    }

    final body = response.data;
    if (body is! Map<String, dynamic>) {
      handler.next(response);
      return;
    }

    final parsedBody = NetworkResponse.fromJson(body);

    if (parsedBody != null) {
      response.data = parsedBody.data;
      response.extra[NetworkConstant.pagination] = parsedBody.pagination;
      handler.next(response);
      return;
    }

    handler.next(response);
  }
}
