import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/appcolor.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String routeName;
  final IconData iconData;

  const CardWidget({
    super.key,
    required this.title,
    required this.routeName,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      child: InkWell(
        enableFeedback: true,
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 28,
              color: AppColor.secondaryColor,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.0,
                color: AppColor.secondaryColor,
                fontFamily: GoogleFonts.nunito().fontFamily,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
