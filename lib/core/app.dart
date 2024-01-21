import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/router/app_routes.dart';
import '../config/themes/app_theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Age Care App',
      themeMode: ThemeMode.system,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      //theme: AppTheme.getApplicationTheme(isDark: false),
      initialRoute: MyRoutes.homeRoute,
      routes: MyRoutes.getApplicationRoute(),
      builder: EasyLoading.init(),
    );
  }
}
