import 'package:age_care/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardWidget extends StatelessWidget {
  final String title;
  final String routeName;
  final String imagePath; // Add imagePath for image

  const CardWidget({
    Key? key,
    required this.title,
    required this.routeName,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: AppColors.whiteText,
      color: AppColors.whiteText,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 1.0,
      child: InkWell(
        enableFeedback: true,
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
                color: Theme.of(context).textTheme.bodyMedium!.color,
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
