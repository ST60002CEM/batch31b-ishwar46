import 'package:flutter/widgets.dart';

import '../../../widgets/card_widget.dart';

class ServiceRowTwo extends StatelessWidget {
  const ServiceRowTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 120,
          height: 140,
          padding: const EdgeInsets.all(10),
          child: const CardWidget(
            title: "Emergency",
            routeName: "/hospital",
            imagePath: "assets/img/emergency.png",
          ),
        ),
        Container(
          width: 120,
          height: 140,
          padding: const EdgeInsets.all(10),
          child: const CardWidget(
            title: "Hospital",
            routeName: "",
            imagePath: "assets/img/hospital.png",
          ),
        ),
        Container(
          width: 120,
          height: 140,
          padding: const EdgeInsets.all(10),
          child: const CardWidget(
            title: "Schedules",
            routeName: "",
            imagePath: "assets/img/grandma.png",
          ),
        ),
      ],
    );
  }
}
