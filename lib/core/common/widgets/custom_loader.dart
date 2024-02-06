import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../config/constants/app_colors.dart';
import '../../../utils/size_config.dart';

class CustomLoaderWidget extends StatefulWidget {
  const CustomLoaderWidget({super.key});

  @override
  State<CustomLoaderWidget> createState() => _CustomLoaderWidgetState();
}

class _CustomLoaderWidgetState extends State<CustomLoaderWidget> {
  SizeConfig screen = SizeConfig();
  @override
  Widget build(BuildContext context) {
    //AppLocalizations localization = AppLocalizations.of(context)!;
    screen.init(context);
    return Container(
      height: screen.screenHeight,
      width: screen.screenHeight,
      color: AppColors.whiteText,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder(
              lottie: AssetLottie(
                'assets/lottie/paperplane.json',
              ),
              width: 200,
              height: 200,
              repeat: true,
            ),
            SizedBox(
              height: 18,
            ),
            Text(
              'Please wait...',
              style: TextStyle(letterSpacing: 1, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
