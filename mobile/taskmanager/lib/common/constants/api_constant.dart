enum ApiConstants {
  authLogin("$baseURL/account/login"),
  authRegister("$baseURL/account/register"),
  task("$baseURL/mission");

  final String value;
  const ApiConstants(this.value);
}

// const String baseURL = "http://localhost:5245/backend";
const String baseURL = "http://192.168.68.107:5245/backend";
