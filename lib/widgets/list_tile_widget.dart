import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/constants/app_colors.dart';

class CustomListTileWidget extends StatelessWidget {
  final List<ListTileData> tileDataList;

  CustomListTileWidget({required this.tileDataList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: tileDataList
          .map(
            (tileData) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              margin: EdgeInsets.only(top: 5),
              child: ListTile(
                hoverColor: AppColors.accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                style: ListTileStyle.list,
                tileColor: Theme.of(context).listTileTheme.tileColor,
                //leading: Icon(tileData.iconData),
                isThreeLine: true,
                title: Text(
                  tileData.title,
                  style: GoogleFonts.montserrat(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
                subtitle: Text(
                  tileData.subtitle,
                  style: GoogleFonts.montserrat(
                    color: Theme.of(context).textTheme.bodyText2!.color,
                    fontSize: 12.0,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    EasyLoading.showInfo("This feature is coming soon.");
                  },
                  icon: Icon(Icons.check_box_outline_blank_rounded,
                      color: Theme.of(context).iconTheme.color),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class ListTileData {
  final IconData iconData;
  final String title;
  final String subtitle;

  ListTileData(
      {required this.iconData, required this.title, required this.subtitle});
}
