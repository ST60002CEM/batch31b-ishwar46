import 'package:flutter/material.dart';

class CustomChipTheme {
  CustomChipTheme._();

  //Light Mode Custom Chip Theme
  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: const Color.fromARGB(255, 12, 69, 117),
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: Colors.white,
  );

  //Dark Mode Custom Chip Theme

  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.white),
    selectedColor: const Color.fromARGB(255, 12, 69, 117),
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
    checkmarkColor: Colors.white,
  );
}
