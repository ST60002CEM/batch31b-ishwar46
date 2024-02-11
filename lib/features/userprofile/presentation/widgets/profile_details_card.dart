import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/constants/app_colors.dart';

class UserDetailsCard extends StatelessWidget {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String address;
  final String age;
  final String username;

  UserDetailsCard({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.age,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle = GoogleFonts.montserrat(
        fontWeight: FontWeight.w500, color: AppColors.primaryColor);
    final TextStyle subtitleStyle = GoogleFonts.montserrat(color: Colors.grey);

    return Card(
      surfaceTintColor: AppColors.whiteText,
      color: AppColors.whiteText,
      margin: EdgeInsets.all(10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text("Full Name", style: titleStyle),
              subtitle: Text(fullName, style: subtitleStyle),
              leading: Icon(Icons.person, color: AppColors.primaryColor),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text("Email", style: titleStyle),
              subtitle: Text(email, style: subtitleStyle),
              leading: Icon(Icons.email, color: AppColors.primaryColor),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text("Phone Number", style: titleStyle),
              subtitle: Text(phoneNumber, style: subtitleStyle),
              leading: Icon(Icons.phone, color: AppColors.primaryColor),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text("Address", style: titleStyle),
              subtitle: Text(address, style: subtitleStyle),
              leading: Icon(Icons.location_on, color: AppColors.primaryColor),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text("Age", style: titleStyle),
              subtitle: Text(age, style: subtitleStyle),
              leading: Icon(Icons.cake, color: AppColors.primaryColor),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text("Username", style: titleStyle),
              subtitle: Text(username, style: subtitleStyle),
              leading: Icon(Icons.verified_user, color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}
