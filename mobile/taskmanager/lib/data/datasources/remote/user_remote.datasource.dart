import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:taskmanager/common/constants/api_constant.dart';
import 'package:taskmanager/data/dtos/auth_login.dto.dart';
import 'package:taskmanager/data/dtos/auth_register.dto.dart';
import 'package:taskmanager/data/dtos/auth_response.dto.dart';

class UserRemoteDatasource {
  final _dio = Dio();

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
