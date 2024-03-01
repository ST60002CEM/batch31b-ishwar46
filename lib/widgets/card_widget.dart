import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/constants/app_colors.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String routeName;
  final String imagePath;
  final bool isDarkMode;

  const CardWidget({
    Key? key,
    required this.title,
    required this.routeName,
    required this.imagePath,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: isDarkMode ? AppColors.black : AppColors.whiteText,
      color: isDarkMode ? AppColors.black : AppColors.whiteText,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 1.0,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 28,
              height: 28,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.0,
                color: isDarkMode ? Colors.white : Colors.black,
                fontFamily: GoogleFonts.montserrat().fontFamily,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
