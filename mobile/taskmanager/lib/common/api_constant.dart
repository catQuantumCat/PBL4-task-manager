enum apiEndpoints {
  authLogin("$baseURL/account/login"),
  authRegister("$baseURL/account/register"),
  task("$baseURL/mission");

  final String value;
  const apiEndpoints(this.value);
}

const String baseURL = "http://10.0.2.2:5245/backend";
