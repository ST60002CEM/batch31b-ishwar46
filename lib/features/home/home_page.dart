import 'package:age_care/core/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../config/constants/app_colors.dart';
import '../../views/home/home_page.dart';
import '../profile/presentation/view/user_profile_view.dart';
import '../qr_code/qr_code.dart';
import '../settings/presentation/view/settings_view.dart';

class HomePageNew extends StatefulWidget {
  const HomePageNew({Key? key, this.firebaseToken}) : super(key: key);

  final String? firebaseToken;

  @override
  State<HomePageNew> createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final List _children = [
    const HomePage(),
    const QRCodeView(),
    const SettingsView(),
    const UserProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = HelperFunctions.isDarkMode(context);
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "",
                style: const TextStyle(fontFamily: 'productSans', fontSize: 16),
              ),
              content: Text(
                "",
                style: const TextStyle(fontFamily: 'productSans'),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text("",
                      style: const TextStyle(fontFamily: 'productSans')),
                ),
                TextButton(
                  onPressed: () async {},
                  child: Text("Yes",
                      style: const TextStyle(fontFamily: 'productSans')),
                ),
              ],
            ),
          ) ??
          false;
    }

    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          showExitPopup();
        }
      },
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Scaffold(
          body: ShowCaseWidget(
            onStart: (index, key) {},
            onComplete: (index, key) {},
            blurValue: 1,
            builder: Builder(
              builder: (context) => Center(
                child: _children.elementAt(_currentIndex),
              ),
            ),
            autoPlayDelay: const Duration(seconds: 3),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: isDarkMode ? AppColors.darkModeOnPrimary : Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8),
                child: GNav(
                  haptic: true,
                  rippleColor: AppColors.grey,
                  hoverColor: AppColors.grey,
                  gap: 8,
                  activeColor:
                      isDarkMode ? Colors.white : AppColors.primaryColor,
                  iconSize: 24,
                  textStyle: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 12.0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor:
                      isDarkMode ? AppColors.primaryColor : Colors.white,
                  color: isDarkMode ? Colors.white : Colors.black,
                  tabs: [
                    GButton(
                      icon: Iconsax.home,
                      text: "Home",
                    ),
                    GButton(
                      icon: Icons.qr_code_2_rounded,
                      text: "QR",
                    ),
                    GButton(
                      icon: Iconsax.settings,
                      text: "Settings",
                    ),
                    GButton(
                      icon: Iconsax.user,
                      text: "Profile",
                    ),
                  ],
                  selectedIndex: _currentIndex,
                  onTabChange: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
