enum ApiConstants {
  authLogin("$baseURL/account/login"),
  authRegister("$baseURL/account/register"),
  task("$baseURL/mission");

  final String value;
  const ApiConstants(this.value);
}

const String baseURL = "http://localhost:5245/backend";
