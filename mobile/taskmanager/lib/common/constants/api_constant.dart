enum ApiConstants {
  authLogin("$baseURL/account/login"),
  authRegister("$baseURL/account/register"),
  task("$baseURL/mission");

  final String value;
  const ApiConstants(this.value);
}

const String baseURL = "http://10.0.2.2:5245/backend";
// const String baseURL = "https://fnnprdph-5245.asse.devtunnels.ms/backend";
