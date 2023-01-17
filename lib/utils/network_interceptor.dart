import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class NetworkInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST[${options.method}] -> PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE[${response.statusCode}] <- PATH: ${response.requestOptions.path}');
    log('DATA => ${jsonEncode(response.data)}');
    return super.onResponse(response, handler);
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) {
    log('ERROR[${err.response?.statusCode}] <- Message: ${err.message}');
    return super.onError(err, handler);
  }
}
