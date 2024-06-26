import 'dart:async';

import 'package:age_care/utils/size_config.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/router/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SizeConfig screen = SizeConfig();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    checkTokenValidity();
  }

  void checkTokenValidity() async {
    final String? token = await secureStorage.read(key: "authToken");

    await Future.delayed(const Duration(seconds: 3));
    if (token != null && !JwtDecoder.isExpired(token)) {
      Navigator.pushReplacementNamed(context, MyRoutes.dahboardRoute);
    } else {
      Navigator.pushReplacementNamed(context, MyRoutes.preloginRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    screen.init(context);
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            SizedBox(
              height: screen.screenHeight,
              width: screen.screenWidth,
              child: Image.asset('assets/img/splashbg.png',
                  fit: BoxFit.fill,
                  color: AppColors.primaryColor,
                  colorBlendMode: BlendMode.lighten),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: screen.screenWidth / 2,
                        child: FadeInUp(
                          duration: const Duration(seconds: 2),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              "assets/img/logo.png",
                              height: MediaQuery.of(context).size.width,
                              width: MediaQuery.of(context).size.width,
                              color: AppColors.whiteText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: FadeIn(
                    child: const Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Developed By: \nClosed AI",
                        style: const TextStyle(
                            fontFamily: "productSans",
                            letterSpacing: 1.2,
                            fontSize: 12,
                            color: Colors.white60),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
