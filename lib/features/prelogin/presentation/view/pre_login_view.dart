import 'package:age_care/core/utils/helpers/helper_functions.dart';
import 'package:card_swiper/card_swiper.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/image_strings.dart';
import '../../../../core/common/provider/biometric_provider.dart';
import '../widgets/biometric_button.dart';
import '../widgets/login_button.dart';
import '../widgets/services_card_widget.dart';
import '../widgets/vertical_card.dart';

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
    final isBiometricVisible = ref.watch(biometricProvider);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: AppColors.primaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
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
            if (isBiometricVisible) ...[
              Biometric(),
              SizedBox(width: 15),
            ],
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
                    height: 20,
                  ),
                  ServicesCard(),
                  SizedBox(
                    height: 20,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "News and Offers",
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(height: 200, child: NewsSlider()),
                  SizedBox(
                    height: 20,
                  ),
                  //Version and Copyright
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Version 1.0.0",
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
