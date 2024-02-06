class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1);
  static const Duration receiveTimeout = Duration(seconds: 1);

  // For Android Emulator Device
  //static const String baseUrl = "http://10.0.2.2:5000/";

  // For IOS Emulator Device
  // static const String baseUrl = "http://localhost:5000/";

  //From WIFI or IP config
  //DishHome Fiber
  static const String baseUrl = "http://192.168.18.236:5000/";
  //My Phone IP
  //static const String baseUrl = "http://172.20.10.2:5000/";

  // Auth Routes
  static const String login = "api/users/login";
  static const String register = "api/users/create";

  //Staff Routes
  static const String allstaff = "api/users/getallstaffs";
  static const String deletestaff = "/api/users/delete";

  //Booking Appointment
  static const String bookappointment = "api/appointments/create";

  static const limitPage = 8;
}
