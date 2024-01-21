import 'package:age_care/features/appointment/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/router/app_routes.dart';
import '../config/themes/app_theme.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(appThemeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Age Care App',
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      //theme: AppTheme.getApplicationTheme(isDark: false),
      initialRoute: MyRoutes.splashRoute,
      routes: MyRoutes.getApplicationRoute(),
      builder: EasyLoading.init(),
    );
  }
}
