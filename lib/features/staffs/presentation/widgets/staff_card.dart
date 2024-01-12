import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StaffCard extends StatelessWidget {
  final String staffName;
  final String staffAddress;
  final String routeName;
  final String imageUrl;

  const StaffCard({
    Key? key,
    required this.staffName,
    required this.staffAddress,
    required this.routeName,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 1.0,
        child: InkWell(
          enableFeedback: true,
          onTap: () {
            //Navigator.pushNamed(context, routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Staff Image
                CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(imageUrl),
                ),
                const SizedBox(
                  height: 8,
                ),
                // Staff Name
                Text(
                  staffName,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
                // Staff Address
                Text(
                  staffAddress,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Theme.of(context).textTheme.bodyMedium!.color,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
