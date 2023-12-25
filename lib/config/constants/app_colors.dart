import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
//Basic Colors
  static const Color primaryColor = Color(0XFF123F6B);
  static const Color secondaryColor = Colors.pinkAccent;
  static const Color accentColor = Color.fromARGB(255, 42, 136, 229);

  //Text Colors
  static const Color primaryTextColor = Color(0xFF333333);
  static const Color secondaryTextColor = Color(0xFF6C757D);
  static const whiteText = Colors.white;

  //Background Colors
  static const Color light = Color(0xFFF6F6F6);
  static const Color dark = Color(0xFF272727);
  static const Color primaryBackground = Color(0xFFF3F5FF);

  //Gradient Colors
  static const Gradient linearGradient = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.505, -0.505),
    colors: [
      Color(0XFF123F6B),
      Color.fromARGB(255, 40, 128, 217),
      Color.fromARGB(255, 35, 115, 196),
    ],
  );

//Background COntainers Colors
  static const Color lightContainer = Color(0xFFF6f6f6);
  static Color darkContainer = AppColors.whiteText.withOpacity(0.1);

  //Button Colors
  static const Color buttonPrimary = Color(0XFF123F6B);
  static const Color buttonSecondary = Colors.grey;
  static const Color buttonDisabled = Color(0xFFC4C4C4);

  //Border Colors
  static const Color borderPrimary = Color(0xFFD9D9D9);
  static const Color borderSecondary = Color(0xFFE6E6E6);

  //Error and Validation Colors
  static const Color error = Color.fromARGB(255, 220, 58, 46);
  static const Color success = Color.fromARGB(255, 61, 138, 64);
  static const Color warning = Colors.orange;
  static const Color info = Colors.blue;

  //Neutral Shades

  static const Color black = Colors.black;
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0XFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);
}
