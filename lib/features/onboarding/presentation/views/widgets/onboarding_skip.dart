import 'package:flutter/material.dart';

import '../../../../../config/constants/app_sizes.dart';

class OnBoardingSkip extends StatelessWidget {
  final VoidCallback onSkip;

  const OnBoardingSkip({
    Key? key,
    required this.onSkip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50,
      right: AppSizes.defaultSpace,
      child: TextButton(
        onPressed: onSkip,
        child: Text('Skip'),
      ),
    );
  }
}
