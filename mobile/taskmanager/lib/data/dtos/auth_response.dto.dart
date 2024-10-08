import 'dart:convert';

class AuthResponseDTO {
  final String username;
  final String email;
  final String token;
  AuthResponseDTO({
    required this.username,
    required this.email,
    required this.token,
  });

  factory AuthResponseDTO.fromMap(Map<String, dynamic> map) {
    return AuthResponseDTO(
      username: map['username'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
    );
  }

  factory AuthResponseDTO.fromJson(String source) =>
      AuthResponseDTO.fromMap(json.decode(source) as Map<String, dynamic>);
}
