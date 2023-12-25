import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../config/constants/app_colors.dart';
import '../../../../../config/constants/app_sizes.dart';
import '../../../../../core/utils/devices/device_utility.dart';
import '../../../../../core/utils/helpers/helper_functions.dart';

class OnBoardingDots extends StatelessWidget {
  final PageController controller;
  final int pageCount;

  const OnBoardingDots({
    Key? key,
    required this.controller,
    required this.pageCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: AppDeviceUtils.getBottomNavigationBarheight() + 25,
      left: AppSizes.defaultSpace,
      child: SmoothPageIndicator(
        effect: ExpandingDotsEffect(
          dotHeight: 10,
          dotWidth: 10,
          dotColor: Colors.grey,
          activeDotColor: dark ? AppColors.light : AppColors.dark,
        ),
        controller: controller,
        count: pageCount,
      ),
    );
  }
}
