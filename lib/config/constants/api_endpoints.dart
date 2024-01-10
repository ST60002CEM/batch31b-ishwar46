class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // For Windows
  // static const String baseUrl = "http://10.0.2.2:3000/api/v1/";
  // For MAC
  static const String baseUrl = "http://10.0.2.2:5000/";

  //From WIFI or IP config
  //static const String baseUrl = "http://192.168.4.4:3000/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "api/users/login";
  static const String register = "api/users/create";
}
