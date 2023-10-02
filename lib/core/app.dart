import 'package:age_care/views/home/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Care App',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        MyRoutes.homeRoute: (context) => const HomePage(),
      },
    );
  }
}

class MyRoutes {
  static String homeRoute = "/home";
}
