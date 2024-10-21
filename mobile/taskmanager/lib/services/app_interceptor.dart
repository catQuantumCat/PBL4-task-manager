import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:taskmanager/common/constants/hive_constant.dart';

class AppInterceptor extends QueuedInterceptor {
  final Box _tokenBox;

  AppInterceptor({required Box tokenBox}) : _tokenBox = tokenBox;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    final token = _tokenBox.get(HiveConstant.token);

    if (token != null) {
      options.headers.addAll({HttpHeaders.authorizationHeader: "Bearer $token"});

    }

    log('Request [${options.method}] => PATH: ${options.path}');
    log('Request Headers: ${options.headers}');
    log('Request Data: ${options.data}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("App interceptor: ${err.message}");
    log("App interceptor: ${err.response}");
    log("Error data: ${err.response?.data}");
    log("Error headers: ${err.response?.headers}");
    log("Error status code: ${err.response?.statusCode}");

    super.onError(err, handler);
  }
}
