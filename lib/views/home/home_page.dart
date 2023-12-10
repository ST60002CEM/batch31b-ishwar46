import 'package:age_care/styles/appcolor.dart';
import 'package:age_care/views/login/login_page.dart';
import 'package:age_care/widgets/list_tile_widget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../widgets/card_widget.dart';
import '../../widgets/drawer_widget.dart';
import '../appointment/appointments_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

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
    AppointmentsPage(),
    //EventsPage(),
    //ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 75, 125),
        title: const Text("WELCOME"),
        titleTextStyle: GoogleFonts.montserrat(
          color: AppColor.whiteText,
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
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.warning,
                animType: AnimType.bottomSlide,
                title: "Logout",
                titleTextStyle: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                desc: "Are you sure you want to logout?",
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
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
                          color: Theme.of(context).secondaryHeaderColor,
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
                            color: Theme.of(context).secondaryHeaderColor,
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
                    width: 100,
                    height: 110,
                    padding: const EdgeInsets.all(10),
                    child: const CardWidget(
                      title: "Appointment",
                      routeName: "/hospital",
                      iconData: Icons.local_hospital,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 110,
                    padding: const EdgeInsets.all(10),
                    child: const CardWidget(
                      title: "Health Care",
                      routeName: "/appointment",
                      iconData: Icons.healing,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 110,
                    padding: const EdgeInsets.all(10),
                    child: const CardWidget(
                      title: "Carer Details",
                      routeName: "/appointment",
                      iconData: Icons.policy,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 110,
                    padding: const EdgeInsets.all(10),
                    child: const CardWidget(
                      title: "Clinics",
                      routeName: "/appointment",
                      iconData: Icons.local_hospital_outlined,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 100,
                    height: 110,
                    padding: const EdgeInsets.all(10),
                    child: const CardWidget(
                      title: "Appointment",
                      routeName: "/hospital",
                      iconData: Icons.local_hospital,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 110,
                    padding: const EdgeInsets.all(10),
                    child: const CardWidget(
                      title: "Appointment",
                      routeName: "/appointment",
                      iconData: Icons.apartment_outlined,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 110,
                    padding: const EdgeInsets.all(10),
                    child: const CardWidget(
                      title: "Appointment",
                      routeName: "/appointment",
                      iconData: Icons.schedule,
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 110,
                    padding: const EdgeInsets.all(10),
                    child: const CardWidget(
                      title: "Hospital",
                      routeName: "/appointment",
                      iconData: Icons.local_hospital,
                    ),
                  ),
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
                          color: Theme.of(context).secondaryHeaderColor,
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
                            color: Theme.of(context).secondaryHeaderColor,
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        unselectedItemColor: AppColor.primaryColor,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: const Text("Home"),
              selectedColor: AppColor.secondaryColor),
          SalomonBottomBarItem(
            icon: const Icon(Icons.favorite_border),
            title: const Text("Likes"),
            selectedColor: AppColor.secondaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.calendar_month_sharp),
            title: const Text("Events"),
            selectedColor: AppColor.secondaryColor,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: AppColor.secondaryColor,
          ),
        ],
      ),
    );
  }
}
