import 'package:age_care/core/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/constants/app_colors.dart';
import 'core/network/hive_service.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: AppColors.primaryColor,
    statusBarColor: AppColors.primaryColor,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ripple
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = AppColors.black
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..maskType = EasyLoadingMaskType.clear
    ..maskColor = Colors.transparent
    ..errorWidget = const Icon(
      Icons.error,
      color: Colors.red,
      size: 40,
    )
    ..successWidget = const Icon(
      Icons.check,
      color: Colors.green,
      size: 40,
    )
    ..indicatorColor = AppColors.whiteText
    ..textStyle = const TextStyle(
      color: Colors.white,
    )
    ..userInteractions = false
    ..fontSize = 12
    ..indicatorSize = 30.0
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale
    ..toastPosition = EasyLoadingToastPosition.top;
}
