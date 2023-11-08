import 'dart:async';

import 'package:age_care/styles/appcolor.dart';
import 'package:age_care/utils/size_config.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'views/login/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SizeConfig screen = SizeConfig();
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return const LoginPage();
        },
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    screen.init(context);
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            SizedBox(
              height: screen.screenHeight,
              width: screen.screenWidth,
              child: Image.asset('assets/img/splashbg.png',
                  fit: BoxFit.fill,
                  color: AppColor.primaryColor,
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
                              color: AppColor.whiteText,
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
