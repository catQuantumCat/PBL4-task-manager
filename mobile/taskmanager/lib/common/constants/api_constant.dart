enum ApiConstants {
  authLogin("$baseURL/account/login"),
  authRegister("$baseURL/account/register"),
  task("$baseURL/mission"),
  changeUserInfo("$baseURL/account/editUserClient");

  final String value;
  const ApiConstants(this.value);
}

const String baseURL =
    "${const String.fromEnvironment("BASE_API_URL")}/backend";
