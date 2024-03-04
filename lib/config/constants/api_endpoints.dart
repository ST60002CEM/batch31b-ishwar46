class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1);
  static const Duration receiveTimeout = Duration(seconds: 5);

  // For Android Emulator Device
  //static const String baseUrl = "http://10.0.2.2:5000/";

  // For IOS Emulator Device
  // static const String baseUrl = "http://localhost:5000/";

  //From WIFI or IP config
  //DishHome Fiber
  //static const String baseUrl = "http://192.168.18.236:5000/";
  //static const String baseUrl = "http://172.25.10.25:5000/";

  //Home 192.168.10.70
  static const String baseUrl = "http://192.168.10.70:5000/";
  //My Phone IP
  //static const String baseUrl = "http://172.20.10.2:5000/";

//College
  //static const String baseUrl = "http://172.26.0.254:5000/";
  // Auth Routes
  static const String login = "api/users/login";
  static const String register = "api/users/create";

  //Staff Routes
  static const String allstaff = "api/users/getallusers";
  static const String deletestaff = "/api/users/delete";

  //Appointment Routes
  static const String bookappointment = "api/appointment/create_appointment";
  static const String getallappoitments = "api/appointment/get_appointment";
  static const String deleteAppointment = "api/appointment/delete_appointment";
  static const String editAppointment = "api/appointment/edit_appointment";

  //Notification Routes
  static const String allnotifications = "api/notifications/user/";

  //Services
  static const String allservices = "api/services";

  //OTP Routes
  static const String sendOTP = "api/send-otp";
  static const String verifyandUpdatePassword =
      "api/verify-otp-and-update-password";

  //Profile Routes
  static const String profile = "api/users/profile";
  static const String editProfile = "api/users/edit";

  static const limitPage = 10;
}
