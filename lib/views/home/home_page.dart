import 'dart:async';

import 'package:age_care/widgets/list_tile_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shake/shake.dart';

import '../../config/constants/app_colors.dart';

import '../../features/auth/presentation/view/login/login_view.dart';
import '../../widgets/card_widget.dart';
import '../../widgets/drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late ShakeDetector shakeDetector;
  int shakeCount = 0;

  // late final Map<String, dynamic> userData;
  //bool isTokenExpired = _isTokenExpired(); // Check if the token is expired

  List<ListTileData> tileDataList = [
    ListTileData(
        iconData: Icons.calendar_today,
        title: "Medication for Diabetes",
        subtitle: "Wed, Oct 2\n12:00 PM"),
    ListTileData(
        iconData: Icons.calendar_today,
        title: "Short Walk",
        subtitle: "Wed, Oct 2\n12:00 PM"),
    ListTileData(
        iconData: Icons.calendar_today,
        title: "Short Walk",
        subtitle: "Wed, Oct 2\n12:00 PM"),
    ListTileData(
        iconData: Icons.calendar_today,
        title: "Short Walk",
        subtitle: "Wed, Oct 2\n12:00 PM"),
  ];

  final List<Widget> _pages = [
    HomePage(),
    //AppointmentsPage(),
    //EventsPage(),
    //ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();

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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginView(),
          ),
        );
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 75, 125),
        title: const Text("WELCOME"),
        titleTextStyle: GoogleFonts.montserrat(
          color: AppColors.whiteText,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        elevation: 0,
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.menu),
        //   onPressed: () {
        //   },
        // ),
        actions: [
          IconButton(
            color: AppColors.whiteText,
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            color: AppColors.whiteText,
            icon: const Icon(Icons.logout),
            onPressed: () {
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginView(),
                    ),
                  );
                },
              ).show();
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
                          color: Colors.amber,
                        ),
                        child: Image.asset(
                          i,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Our Services",
                        style: GoogleFonts.montserrat(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          EasyLoading.showInfo("This feature is coming soon.");
                        },
                        child: Text(
                          "View All",
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 120,
                    height: 140,
                    padding: const EdgeInsets.all(10),
                    child: const CardWidget(
                      title: "Appointment",
                      routeName: "/appointmentspage",
                      imagePath: "assets/img/appointment.png",
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 140,
                    padding: const EdgeInsets.all(10),
                    child: const CardWidget(
                      title: "Health Care",
                      routeName: "/appointment",
                      imagePath: "assets/img/doctor.png",
                    ),
                  ),
                  // Container(
                  //   width: 100,
                  //   height: 110,
                  //   padding: const EdgeInsets.all(10),
                  //   child: const CardWidget(
                  //     title: "Carer Details",
                  //     routeName: "/appointment",
                  //     iconData: Icons.policy,
                  //   ),
                  // ),
                  Container(
                    width: 120,
                    height: 140,
                    padding: const EdgeInsets.all(10),
                    child: const CardWidget(
                      title: "Staffs",
                      routeName: "/staffdetails",
                      imagePath: "assets/img/medicalteam.png",
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 120,
                    height: 140,
                    padding: const EdgeInsets.all(10),
                    child: const CardWidget(
                      title: "Emergency",
                      routeName: "/hospital",
                      imagePath: "assets/img/emergency.png",
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 140,
                    padding: const EdgeInsets.all(10),
                    child: const CardWidget(
                      title: "Hospital",
                      routeName: "/appointment",
                      imagePath: "assets/img/hospital.png",
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 140,
                    padding: const EdgeInsets.all(10),
                    child: const CardWidget(
                      title: "Schedules",
                      routeName: "/appointment",
                      imagePath: "assets/img/grandma.png",
                    ),
                  ),
                  // Container(
                  //   width: 100,
                  //   height: 110,
                  //   padding: const EdgeInsets.all(10),
                  //   child: const CardWidget(
                  //     title: "Hospital",
                  //     routeName: "/appointment",
                  //     iconData: Icons.local_hospital,
                  //   ),
                  // ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Reminders",
                        style: GoogleFonts.montserrat(
                          color: Theme.of(context).primaryColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          EasyLoading.showInfo("This feature is coming soon.");
                        },
                        child: Text(
                          "View All",
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              //For Reminders
              CustomListTileWidget(tileDataList: tileDataList),

              // Container(
              //   child: Text(
              //     'First Name: ${userData['firstName']}',
              //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //   ),
              // )
            ],
          ),
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        unselectedItemColor: AppColors.primaryColor,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              selectedColor: AppColors.secondaryColor),
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite_border),
            title: const Text("Likes"),
            selectedColor: AppColors.secondaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.calendar_month_sharp),
            title: const Text("Events"),
            selectedColor: AppColors.secondaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: AppColors.secondaryColor,
          ),
        ],
      ),
    );
  }
}
