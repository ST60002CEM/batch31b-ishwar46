import 'package:age_care/views/signup/signup_page.dart';

import '../../features/auth/presentation/view/login/login_view.dart';
import '../../features/onboarding/presentation/views/onboarding_screens.dart';
import '../../features/splash/presentation/view/splash_screen.dart';
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

  static getApplicationRoute() {
    return {
      homeRoute: (context) => HomePage(),
      loginRoute: (context) => LoginView(),
      signupRoute: (context) => SignUpPage(),
      appointmentsRoute: (context) => AppointmentsPage(),
      splashRoute: (context) => SplashScreen(),
      onBoardingRoute: (context) => OnBoardingScreen(),
    };
  }
}
