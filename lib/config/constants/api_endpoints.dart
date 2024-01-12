class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);

  // For Android Device
  static const String baseUrl = "http://10.0.2.2:5000/";

  // For IOS Device
  // static const String baseUrl = "http://localhost:5000/";

  //From WIFI or IP config
  //static const String baseUrl = "http://192.168.4.4:3000/api/v1/";

  // Auth Routes
  static const String login = "api/users/login";
  static const String register = "api/users/create";

  //Staff Routes
  static const String allstaff = "api/users/getallstaffs";
}
