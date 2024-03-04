import 'package:flutter/material.dart';

import '../../../widgets/card_widget.dart';

class ServiceRowTwo extends StatelessWidget {
  const ServiceRowTwo({
    Key? key,
    required this.isDarkMode,
  }) : super(key: key);

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 120,
          height: 140,
          padding: const EdgeInsets.all(10),
          child: CardWidget(
            title: "Emergency",
            routeName: "/hospital",
            imagePath: "assets/img/emergency.png",
            isDarkMode: isDarkMode,
          ),
        ),
        Container(
          width: 120,
          height: 140,
          padding: const EdgeInsets.all(10),
          child: CardWidget(
            title: "Notes",
            routeName: "/notesRoute",
            imagePath: "assets/img/notes.png",
            isDarkMode: isDarkMode,
          ),
        ),
        Container(
          width: 120,
          height: 140,
          padding: const EdgeInsets.all(10),
          child: CardWidget(
            title: "Schedules",
            routeName: "",
            imagePath: "assets/img/grandma.png",
            isDarkMode: isDarkMode,
          ),
        ),
      ],
    );
  }
}
