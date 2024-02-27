import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shake/shake.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:age_care/config/router/app_routes.dart';
import 'package:age_care/core/utils/helpers/helper_functions.dart';
import 'package:age_care/widgets/drawer_widget.dart';
import 'package:age_care/config/constants/app_colors.dart';
import 'package:age_care/views/home/widgets/service_text.dart';
import 'package:age_care/views/home/widgets/service_row.dart';
import 'package:age_care/views/home/widgets/service_row_two.dart';
import 'widgets/emergency_bottom_sheet.dart';
import 'widgets/slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ShakeDetector shakeDetector;
  int shakeCount = 0;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String? username;

  @override
  void initState() {
    super.initState();
    shakeDetector = ShakeDetector.autoStart(
      onPhoneShake: _handleShake,
    );
    _getUsername();
  }

  @override
  void dispose() {
    shakeDetector.stopListening();
    super.dispose();
  }

  void _handleShake() {
    shakeCount++;
    if (shakeCount >= 2) {
      shakeCount = 0;
      _showEmergencyBottomSheet();
    }
    Timer(Duration(seconds: 3), () {
      shakeCount = 0;
    });
  }

  Future<void> _getUsername() async {
    final username = await HelperFunctions.getUsernameFromToken();
    setState(() {
      this.username = username ?? 'Guest';
    });
  }

  void _showEmergencyBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => EmergencyBottomSheet(),
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
      btnOkOnPress: logout,
    ).show();
  }

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
        appBar: _buildAppBar(),
        drawer: MyDrawer(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
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
      actions: _buildAppBarActions(),
    );
  }

  List<Widget> _buildAppBarActions() {
    return [
      IconButton(
        color: AppColors.whiteText,
        icon: const Icon(Icons.notifications),
        onPressed: () {
          Navigator.pushNamed(context, MyRoutes.viewNotificationRoute);
        },
      ),
      IconButton(
        color: AppColors.whiteText,
        icon: const Icon(Icons.logout),
        onPressed: _showLogoutDialog,
      ),
    ];
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            MyCarouselSlider(),
            const SizedBox(height: 10.0),
            ServiceText(),
            ServiceRow(),
            ServiceRowTwo(),
          ],
        ),
      ),
    );
  }
}
