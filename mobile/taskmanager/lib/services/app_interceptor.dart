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
      options.headers
          .addAll({HttpHeaders.authorizationHeader: "Bearer $token"});
    }

    log('Request [${options.method}] => BODY: ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    if (err.response?.statusCode == 401) {
      _tokenBox.delete(HiveConstant.token);
      _tokenBox.delete(HiveConstant.userInfo);
    }

    super.onError(err, handler);
  }
}
