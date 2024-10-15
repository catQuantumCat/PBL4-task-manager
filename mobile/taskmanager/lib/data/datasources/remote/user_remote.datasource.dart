import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:taskmanager/common/constants/api_constant.dart';
import 'package:taskmanager/data/dtos/auth_login.dto.dart';
import 'package:taskmanager/data/dtos/auth_register.dto.dart';
import 'package:taskmanager/data/dtos/auth_response.dto.dart';
import 'package:taskmanager/services/dio_provider.dart';

class UserRemoteDatasource {
  final Box _tokenBox;
  final Dio _dio;

  UserRemoteDatasource({required Box tokenBox})
      : _tokenBox = tokenBox,
        _dio = DioProvider.getDio(tokenBox: tokenBox);

  Future<AuthResponseDTO> submitLogin(AuthLoginDTO credentials) async {
    final response = await _dio.post(apiEndpoints.authLogin.value,
        data: credentials.toJson());

    //TODO: remove
    log(AuthResponseDTO.fromMap(response.data).toString());

    return AuthResponseDTO.fromMap(response.data);
  }

  Future<AuthResponseDTO> submitRegister(AuthRegisterDTO credentials) async {
    final response = await _dio.post(apiEndpoints.authRegister.value,
        data: credentials.toJson());
    //TODO: remove
    log(AuthResponseDTO.fromMap(response.data).toString());
    return AuthResponseDTO.fromMap(response.data);
  }
}
