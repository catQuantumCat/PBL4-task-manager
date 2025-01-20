class AuthEditDTO {
  final String username;
  final String email;
  final String oldPassword;
  final String newPassword;
  AuthEditDTO({
    required this.username,
    required this.email,
    required this.oldPassword,
    required this.newPassword,
  });

  @override
  String toString() {
    return 'AuthEditDTO(username: $username, email: $email, oldPassword: $oldPassword, newPassword: $newPassword)';
  }

  @override
  bool operator ==(covariant AuthEditDTO other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.email == email &&
        other.oldPassword == oldPassword &&
        other.newPassword == newPassword;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        email.hashCode ^
        oldPassword.hashCode ^
        newPassword.hashCode;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }

  factory AuthEditDTO.fromJson(Map<String, dynamic> map) {
    return AuthEditDTO(
      username: map['username'] as String,
      email: map['email'] as String,
      oldPassword: map['oldPassword'] as String,
      newPassword: map['newPassword'] as String,
    );
  }
}


/*
{
  "username": "string",
  "oldPassword": "string",
  "newPassword": "string",
  "email": "string"
}
*/