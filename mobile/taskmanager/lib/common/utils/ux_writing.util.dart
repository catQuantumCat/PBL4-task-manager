


enum UXWritingEnum {
  //ERROR
  //AUTH
    errorAuthInvalidEmail("Invalid email"),
    errorAuthInvalidPassword(
        "Must be at least 12 characters, with uppercase and lower case charaters, numbers and special characters"),
    errorAuthEmptyField("Field cannot be empty"),

  
  ;

  final String value;

  const UXWritingEnum(this.value);
}
