import 'dart:async';

import 'package:age_care/config/router/app_routes.dart';
import 'package:age_care/core/utils/helpers/helper_functions.dart';
import 'package:age_care/views/home/widgets/service_text.dart';
import 'package:age_care/widgets/list_tile_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shake/shake.dart';
import '../../config/constants/app_colors.dart';

import '../../features/auth/presentation/view/login/login_view.dart';
import '../../widgets/card_widget.dart';
import '../../widgets/drawer_widget.dart';
import 'widgets/service_row.dart';
import 'widgets/service_row_two.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late ShakeDetector shakeDetector;
  int shakeCount = 0;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  late String? username;

  // late final Map<String, dynamic> userData;
  //bool isTokenExpired = _isTokenExpired(); // Check if the token is expired

  @override
  void initState() {
    super.initState();
    getUsername();

    // Initialize shake detector
    shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: () {
        shakeCount++;

        // If the user shakes the phone four times, show the emergency bottom sheet
        if (shakeCount >= 2) {
          shakeCount = 0;
          _showEmergencyBottomSheet();
        }
        Timer(Duration(seconds: 3), () {
          shakeCount = 0;
        });
      },
    );
  }

  Future<void> getUsername() async {
    final username = await HelperFunctions.getUsernameFromToken();
    setState(() {
      this.username = username ?? 'Guest';
    });
  }

  @override
  void dispose() {
    // Dispose of shake detector when the widget is disposed
    shakeDetector.stopListening();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showEmergencyBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Report Emergency',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Urgent Emergency Call',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Enter emergency details...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                Hero(
                  tag: 'emergency',
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        EasyLoading.showSuccess(
                            'Emergency reported successfully.',
                            dismissOnTap: false);

                        Navigator.of(context).pop();
                      },
                      child: Text('Submit'),
                    ),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLogoutDialog() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.bottomSlide,
      title: "Logout",
      titleTextStyle: GoogleFonts.montserrat(
        color: AppColors.primaryColor,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      desc: "Are you sure you want to logout?",
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        logout();
      },
    ).show();
  }

  //Logout and Delete Token
  Future<void> logout() async {
    await secureStorage.delete(key: "authToken");

    Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {},
      child: Scaffold(
        backgroundColor: Colors.white.withOpacity(.94),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 15, 75, 125),
          title: Text('Welcome! $username'),
          titleTextStyle: GoogleFonts.montserrat(
            color: AppColors.whiteText,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Iconsax.menu, color: AppColors.whiteText),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: [
            IconButton(
              color: AppColors.whiteText,
              icon: const Icon(Icons.notifications),
              onPressed: () {
                EasyLoading.showInfo("No new notifications.");
              },
            ),
            IconButton(
              color: AppColors.whiteText,
              icon: const Icon(Icons.logout),
              onPressed: () {
                _showLogoutDialog();
              },
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    clipBehavior: Clip.antiAlias,
                    aspectRatio: 10.0,
                    height: 120.0,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                  ),
                  items: [
                    "assets/img/b1.png",
                    "assets/img/b2.png",
                    "assets/img/b1.png",
                  ].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              i,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ServiceText(),
                ServiceRow(),
                ServiceRowTwo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
