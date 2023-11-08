import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/appcolor.dart';

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
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                style: ListTileStyle.list,
                tileColor: AppColor.accent,
                leading: Icon(tileData.iconData),
                title: Text(tileData.title),
                subtitle: Text(tileData.subtitle),
                trailing: IconButton(
                  onPressed: () {
                    EasyLoading.showInfo("This feature is coming soon.");
                  },
                  icon: Icon(Icons.add),
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
