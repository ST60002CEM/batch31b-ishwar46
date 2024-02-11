import '../../features/appointment/presentation/view/book_appointment/appointment_book_view.dart';
import '../../features/appointment/presentation/view/view_appointment/view_appointment.dart';
import '../../features/auth/presentation/view/login/login_view.dart';
import '../../features/auth/presentation/view/signup/register_view.dart';
import '../../features/onboarding/presentation/views/onboarding_screens.dart';
import '../../features/prelogin/presentation/view/pre_login_view.dart';
import '../../features/settings/presentation/view/settings_view.dart';
import '../../features/splash/presentation/view/splash_screen.dart';
import '../../features/staffs/presentation/view/staff_details_view.dart';
import '../../features/userprofile/presentation/view/user_profile.dart';
import '../../views/home/home_page.dart';

class MyRoutes {
  MyRoutes._();

  static const String splashRoute = '/splash';
  static String homeRoute = "/home";
  static String loginRoute = "/loginpage";
  static String signupRoute = "/registerpage";
  static String appointmentsRoute = "/appointmentspage";
  static String onBoardingRoute = "/onboardingpage";
  static String staffDetailsRoute = "/staffdetails";
  static String preloginRoute = "/preloginpage";
  static String smoothpage = "/smoothpage";
  static String lightpage = "/lightpage";
  static String settingsRoute = "/settings";
  static String viewbookedappointment = "/viewbookedappointment";
  static String userProfileRoute = "/userprofile";

  static getApplicationRoute() {
    return {
      homeRoute: (context) => HomePage(),
      loginRoute: (context) => LoginView(),
      signupRoute: (context) => RegisterView(),
      appointmentsRoute: (context) => AppointmentView(),
      splashRoute: (context) => SplashScreen(),
      onBoardingRoute: (context) => OnBoardingScreen(),
      staffDetailsRoute: (context) => AddStaffView(),
      preloginRoute: (context) => PreLoginPage(),
      viewbookedappointment: (context) => ViewBookedAppointments(),
      settingsRoute: (context) => SettingsView(),
      userProfileRoute: (context) => UserProfileView(),
      //smoothpage: (context) => CarouselDemo(),
      // lightpage: (context) => AppointmentsPage(),
    };
  }
}
