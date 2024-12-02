// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String email;
  final String username;

  UserModel({required this.email, required this.username});

  @override
  String toString() => 'UserModel(email: $email, username: $username)';

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'username': username,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      username: map['username'] as String,
    );
  }

  String toJsonString() => json.encode(toJson());

  factory UserModel.fromJsonString(String source) =>
      UserModel.fromJson(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.email == email && other.username == username;
  }

  @override
  int get hashCode => email.hashCode ^ username.hashCode;

  UserModel copyWith({
    String? email,
    String? username,
  }) {
    return UserModel(
      email: email ?? this.email,
      username: username ?? this.username,
    );
  }
}
