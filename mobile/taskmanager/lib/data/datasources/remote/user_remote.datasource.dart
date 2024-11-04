import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:taskmanager/common/constants/api_constant.dart';
import 'package:taskmanager/data/dtos/auth_login.dto.dart';
import 'package:taskmanager/data/dtos/auth_register.dto.dart';
import 'package:taskmanager/data/dtos/auth_response.dto.dart';

class UserRemoteDatasource {
  final Dio _dio;

  UserRemoteDatasource({required Dio dio}) : _dio = dio;

  Future<AuthResponseDTO> submitLogin(AuthLoginDTO credentials) async {
    final response = await _dio.post(ApiConstants.authLogin.value,
        data: credentials.toJson());

    return AuthResponseDTO.fromJson(response.data);
  }

  Future<AuthResponseDTO> submitRegister(AuthRegisterDTO credentials) async {
    final response = await _dio.post(ApiConstants.authRegister.value,
        data: credentials.toJson());

    return AuthResponseDTO.fromJson(response.data);
  }
}
