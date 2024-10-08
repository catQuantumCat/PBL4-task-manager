enum UXWritingEnum {
  //ERROR
  //AUTH
  authInvalidEmail("Invalid email"),
  authInvalidPassword(
      "Must be at least 12 characters, with uppercase and lower case character, numbers and special characters"),
  authEmptyField("Field cannot be empty"),
  ;

  final String value;

  const UXWritingEnum(this.value);
}
