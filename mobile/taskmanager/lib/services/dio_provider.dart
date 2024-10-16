import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:taskmanager/services/app_interceptor.dart';

class DioProvider {
  Dio getDio({required Box tokenBox}) {
    final returnDio = Dio();
    final interceptor = AppInterceptor(tokenBox: tokenBox);
    final List<Interceptor> interceptors = [interceptor];
    returnDio.interceptors.addAll(interceptors);
    return returnDio;
  }
}
