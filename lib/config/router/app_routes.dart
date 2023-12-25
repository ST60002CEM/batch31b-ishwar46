import '../../features/onboarding/presentation/views/onboarding_screens.dart';
import '../../features/splash/presentation/view/splash_screen.dart';
import '../../views/appointment/appointments_page.dart';
import '../../views/home/home_page.dart';
import '../../views/login/login_page.dart';

class MyRoutes {
  MyRoutes._();

  static const String splashRoute = '/splash';
  static String homeRoute = "/home";
  static String loginRoute = "/loginpage";
  static String signupRoute = "/signuppage";
  static String appointmentsRoute = "/appointmentspage";
  static String onBoardingRoute = "/onboardingpage";

  static getApplicationRoute() {
    return {
      homeRoute: (context) => HomePage(),
      loginRoute: (context) => LoginPage(),
      //signupRoute: (context) => SignupPage(),
      appointmentsRoute: (context) => AppointmentsPage(),
      splashRoute: (context) => SplashScreen(),
      onBoardingRoute: (context) => OnBoardingScreen(),
    };
  }
}
