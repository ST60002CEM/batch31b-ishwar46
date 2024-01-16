import 'package:age_care/core/utils/helpers/helper_functions.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/image_strings.dart';
import '../widgets/biometric_button.dart';
import '../widgets/card_widget.dart';
import '../widgets/login_button.dart';

class PreLoginPage extends ConsumerStatefulWidget {
  const PreLoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PreLoginPageState();
}

class _PreLoginPageState extends ConsumerState<PreLoginPage> {
  final List<String> images = [
    'assets/img/banner1.png',
    'assets/img/banner1.png',
    'assets/img/banner1.png',
  ];

  //bioMetric visibility

  //bool isBioMetricVisible = true;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leadingWidth: 100,
        leading: Hero(
          tag: 'logo',
          child: Image(
            height: 180,
            image: AssetImage(
                dark ? AppImages.darkAppLogo : AppImages.lightAppLogo),
          ),
        ),
        actions: [
          //Prelogin Button
          PreLoginButton(),
          SizedBox(
            width: 20,
          ),
          //BioMetric
          Biometric(),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Swiper.children(
                      curve: Curves.easeInOut,
                      autoplay: true,
                      duration: 1000,
                      children: images
                          .map((imagePath) => Image.asset(
                                imagePath,
                                fit: BoxFit.fill,
                              ))
                          .toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Services",
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 110,
                          //padding: const EdgeInsets.all(5),
                          child: const CardWidgetPre(
                            title: "Service 1",
                            routeName: "/hospital",
                            imagePath: AppImages.cardImage1,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 110,
                          //padding: const EdgeInsets.all(10),
                          child: const CardWidgetPre(
                            title: "Service 2",
                            routeName: "/appointment",
                            imagePath: AppImages.cardImage2,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 110,
                          //padding: const EdgeInsets.all(10),
                          child: const CardWidgetPre(
                            title: "Service 3",
                            routeName: "/appointment",
                            imagePath: AppImages.cardImage3,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 110,
                          //padding: const EdgeInsets.all(10),
                          child: const CardWidgetPre(
                            title: "Service 4",
                            routeName: "/appointment",
                            imagePath: AppImages.cardImage4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 180,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Swiper.children(
                      curve: Curves.easeInOut,
                      autoplay: true,
                      duration: 1000,
                      children: images
                          .map((imagePath) => Image.asset(
                                imagePath,
                                fit: BoxFit.fill,
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
