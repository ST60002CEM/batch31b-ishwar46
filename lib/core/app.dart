import 'package:age_care/views/home/home_page.dart';
import 'package:age_care/views/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../splash_screen.dart';
import '../styles/appcolor.dart';
import '../views/signup/signup_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Care App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: AppColor.whiteText,
        primaryColor: AppColor.primaryColor,
        secondaryHeaderColor: AppColor.primaryColor,
        cardColor: AppColor.tertiaryColor,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: AppColor.secondaryColor),
          bodyText2: TextStyle(color: AppColor.primaryColor),
        ),
        iconTheme: const IconThemeData(
          color: AppColor.secondaryColor,
        ),
      ),
      darkTheme: ThemeData(
        cardColor: AppColor.primaryColor,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color.fromARGB(255, 29, 38, 45),
        primaryColor: AppColor.primaryColor,
        secondaryHeaderColor: AppColor.secondaryColorAccent,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: AppColor.whiteText),
          bodyText2: TextStyle(color: AppColor.whiteText),
        ),
        listTileTheme: const ListTileThemeData(
          tileColor: AppColor.primaryColor,
          iconColor: AppColor.secondaryColor,
          textColor: AppColor.secondaryColor,
        ),
        iconTheme: const IconThemeData(
          color: AppColor.whiteText,
        ),
      ),
      builder: EasyLoading.init(),
      home: const SplashScreen(),
      routes: {
        MyRoutes.homeRoute: (context) => const LoginPage(),
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.signupRoute: (context) => const SignUpPage(),
        MyRoutes.appointmentsRoute: (context) => const HomePage(),
      },
    );
  }
}

class MyRoutes {
  static String homeRoute = "/home";
  static String loginRoute = "/loginpage";
  static String signupRoute = "/signuppage";
  static String appointmentsRoute = "/appointmentspage";
}
