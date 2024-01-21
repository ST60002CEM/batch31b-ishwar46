import '../../features/appointment/sensor.dart';
import '../../features/auth/presentation/view/login/login_view.dart';
import '../../features/auth/presentation/view/signup/register_view.dart';
import '../../features/onboarding/presentation/views/onboarding_screens.dart';
import '../../features/prelogin/presentation/view/pre_login_view.dart';
import '../../features/splash/presentation/view/splash_screen.dart';
import '../../features/staffs/presentation/view/staff_details_view.dart';
import '../../views/appointment/appointments_page.dart';
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

  static getApplicationRoute() {
    return {
      homeRoute: (context) => HomePage(),
      loginRoute: (context) => LoginView(),
      signupRoute: (context) => RegisterView(),
      appointmentsRoute: (context) => AppointmentsPage(),
      splashRoute: (context) => SplashScreen(),
      onBoardingRoute: (context) => OnBoardingScreen(),
      staffDetailsRoute: (context) => AddStaffView(),
      preloginRoute: (context) => PreLoginPage(),
      //smoothpage: (context) => CarouselDemo(),
      lightpage: (context) => DarkModePage(),
    };
  }
}
