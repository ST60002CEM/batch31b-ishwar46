import 'package:age_care/config/themes/apptheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import '../config/router/app_routes.dart';
import '../config/themes/app_theme.dart';

class MyApp extends ConsumerWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({
    super.key,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(appThemeProvider);
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Age Care App',
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ne', 'NP'),
      ],
      localizationsDelegates: const [
        KhaltiLocalizations.delegate,
      ],
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
