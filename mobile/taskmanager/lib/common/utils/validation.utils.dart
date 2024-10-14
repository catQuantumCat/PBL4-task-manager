import 'package:taskmanager/common/utils/ux_writing.util.dart';

abstract class ValidationUtils {
  static String? validateEmail(String? value) {
    if (value == null) return UXWritingEnum.authEmptyField.value;
    final RegExp regExp = RegExp(
      r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$',
      caseSensitive: false,
    );
    if (regExp.hasMatch(value)) return null;
    return UXWritingEnum.authInvalidEmail.value;
  }

  static String? validatePassword(String? value) {
    if (value == null) return UXWritingEnum.authEmptyField.value;

    final RegExp regExp = RegExp(
      r'^[a-zA-Z0-9\\d@$!%_*?&]{12,}$',
      caseSensitive: false,
    );
    if (regExp.hasMatch(value)) return null;

    return UXWritingEnum.authInvalidPassword.value;
  }

  static String? validateField(String? value) {
    if (value == null || value.isEmpty) {
      return UXWritingEnum.authEmptyField.value;
    }
    return null;
  }
}

/*
[
  {
    "code": "PasswordTooShort",
    "description": "Passwords must be at least 12 characters."
  },
  {
    "code": "PasswordRequiresNonAlphanumeric",
    "description": "Passwords must have at least one non alphanumeric character."
  },
  {
    "code": "PasswordRequiresDigit",
    "description": "Passwords must have at least one digit ('0'-'9')."
  },
  {
    "code": "PasswordRequiresUpper",
    "description": "Passwords must have at least one uppercase ('A'-'Z')."
  }
]

*/