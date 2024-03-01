import 'package:flutter/material.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/text_strings.dart';
import '../../../../config/router/app_routes.dart';
import '../../../../core/utils/helpers/helper_functions.dart';

class PreLoginButton extends StatelessWidget {
  const PreLoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);
    return SizedBox(
      width: 120,
      child: Hero(
        tag: 'loginbutton',
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, MyRoutes.loginRoute);
          },
          child: Text(
            AppTexts.login.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              shape: const RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              elevation: 2,
              splashFactory: InkRipple.splashFactory,
              backgroundColor: isDarkMode
                  ? AppColors.darkModeOnPrimary
                  : AppColors.primaryColor),
        ),
      ),
    );
  }
}
