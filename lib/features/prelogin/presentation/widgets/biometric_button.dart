import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:local_auth/local_auth.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../views/home/home_page.dart';

class Biometric extends StatelessWidget {
  const Biometric({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () async {
          bool isAuthenticated = await _authenticateUser(context);
          if (isAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
        child: Icon(
          Iconsax.finger_scan,
          size: 20,
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          elevation: 2,
          splashFactory: InkRipple.splashFactory,
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.primaryColor,
        ),
      ),
    );
  }

  Future<bool> _authenticateUser(BuildContext context) async {
    final LocalAuthentication localAuth = LocalAuthentication();

    try {
      bool isAuthenticated = await localAuth.authenticate(
        localizedReason: 'Authenticate to access the app',
      );

      return isAuthenticated;
    } catch (e) {
      // Handle authentication errors
      print('Authentication failed: $e');
      // You may want to show an error message to the user
      return false;
    }
  }
}
