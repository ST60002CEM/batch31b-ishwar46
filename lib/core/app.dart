import 'package:age_care/views/home/home_page.dart';
import 'package:age_care/views/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../views/signup/signup_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Care App',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: const LoginPage(),
      routes: {
        MyRoutes.homeRoute: (context) => const HomePage(),
        MyRoutes.loginRoute: (context) => const LoginPage(),
        MyRoutes.signupRoute: (context) => const SignUpPage(),
      },
    );
  }
}

class MyRoutes {
  static String homeRoute = "/home";
  static String loginRoute = "/loginpage";
  static String signupRoute = "/signuppage";
}
