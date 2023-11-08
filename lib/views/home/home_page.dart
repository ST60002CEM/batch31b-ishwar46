import 'package:age_care/styles/appcolor.dart';
import 'package:age_care/views/login/login_page.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../widgets/card_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 75, 125),
        title: const Text("WELCOME"),
        titleTextStyle: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            EasyLoading.showInfo("This feature is coming soon.");
          },
        ),
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
                        "Quick Access",
                        style: GoogleFonts.montserrat(
                          color: AppColor.primaryColor,
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
                            color: AppColor.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
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
                      title: "Appointment",
                      routeName: "/appointment",
                      iconData: Icons.policy,
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
              const SizedBox(
                height: 20,
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
                          color: AppColor.primaryColor,
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
                            color: AppColor.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //For Reminders
              // ListView(
              //   shrinkWrap: true,
              //   physics: const NeverScrollableScrollPhysics(),
              //   children: [
              //     Container(
              //       color: AppColor.accent,
              //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Container(
              //             padding: const EdgeInsets.all(10),
              //             child: Text(
              //               "Today",
              //               style: GoogleFonts.montserrat(
              //                 color: AppColor.primaryColor,
              //                 fontSize: 15,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     const SizedBox(
              //       height: 10,
              //     ),
              //     Container(
              //       color: AppColor.accent,
              //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Container(
              //             padding: const EdgeInsets.all(10),
              //             child: Text(
              //               "Upcoming",
              //               style: GoogleFonts.montserrat(
              //                 color: AppColor.primaryColor,
              //                 fontSize: 15,
              //                 fontWeight: FontWeight.w600,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     const SizedBox(
              //       height: 10,
              //     ),
              //   ],
              // ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  style: ListTileStyle.list,
                  tileColor: Colors.amber[600],
                  leading: const Icon(Icons.calendar_today),
                  title: const Text("Today"),
                  subtitle: const Text("No Reminders"),
                  trailing: IconButton(
                    onPressed: () {
                      EasyLoading.showInfo("This feature is coming soon.");
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SalomonBottomBar(
        unselectedItemColor: AppColor.primaryColor,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
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
            icon: const Icon(Icons.search),
            title: const Text("Search"),
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
