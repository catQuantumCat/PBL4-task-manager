enum ApiConstants {
  authLogin("$baseURL/backend/account/login"),
  authRegister("$baseURL/backend/account/register"),
  task("$baseURL/backend/mission");

  final String value;
  const ApiConstants(this.value);
}

const String baseURL = String.fromEnvironment("BASE_API_URL");
