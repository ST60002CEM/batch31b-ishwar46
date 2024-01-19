import 'package:age_care/config/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      surfaceTintColor: AppColors.white,
      //color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 1.0,
      child: InkWell(
        enableFeedback: true,
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        // onTap: () {
        //   EasyLoading.showInfo("This feature is coming soon.");
        // },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 28,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.0,
                color: Theme.of(context).textTheme.bodyText2!.color,
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
