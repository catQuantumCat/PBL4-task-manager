// ignore_for_file: public_member_api_docs, sort_constructors_first

class AuthResponseDTO {
  final String username;
  final String email;
  final String token;
  AuthResponseDTO({
    required this.username,
    required this.email,
    required this.token,
  });

  factory AuthResponseDTO.fromJson(Map<String, dynamic> map) {
    return AuthResponseDTO(
      username: map['username'] as String,
      email: map['email'] as String,
      token: map['token'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'token': token,
    };
  }
}
