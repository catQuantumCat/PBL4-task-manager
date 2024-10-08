import 'dart:convert';

class AuthLoginDTO {
  final String userName;
  final String password;
  AuthLoginDTO({
    required this.userName,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());
}
