import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../config/constants/app_colors.dart';
import '../../../../../config/constants/app_sizes.dart';
import '../../../../../core/utils/devices/device_utility.dart';
import '../../../../../core/utils/helpers/helper_functions.dart';

class OnBoardingNextButton extends StatelessWidget {
  final VoidCallback onNext;

  const OnBoardingNextButton({
    Key? key,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Positioned(
      bottom: AppDeviceUtils.getBottomNavigationBarheight(),
      right: AppSizes.defaultSpace,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: dark ? AppColors.primaryColor : AppColors.black,
        ),
        onPressed: onNext, // Call the provided onNext callback when pressed
        child: const Icon(Iconsax.arrow_right_2),
      ),
    );
  }
}
