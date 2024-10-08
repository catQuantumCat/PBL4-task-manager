import 'dart:convert';

class AuthRegisterDTO {
  final String username;
  final String email;
  final String password;
  AuthRegisterDTO({
    required this.username,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
    };
  }
  String toJson() => json.encode(toMap());
}
