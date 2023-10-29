import 'package:age_care/core/app.dart';
import 'package:age_care/styles/appcolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(const MyApp());

  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = Colors.black38
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskType = EasyLoadingMaskType.clear
    ..maskColor = Colors.transparent
    ..indicatorColor = AppColor.primaryColor
    ..textStyle = const TextStyle(
      color: Colors.white,
    )
    ..userInteractions = false
    ..fontSize = 12
    ..indicatorSize = 30.0
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale
    ..toastPosition = EasyLoadingToastPosition.bottom;
}
