import 'package:flutter/material.dart';

import '../../../widgets/card_widget.dart';

class ServiceRow extends StatelessWidget {
  const ServiceRow({
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
            title: "Appointment",
            routeName: "/appointmentspage",
            imagePath: "assets/img/appointment.png",
            isDarkMode: isDarkMode,
          ),
        ),
        Container(
          width: 120,
          height: 140,
          padding: const EdgeInsets.all(10),
          child: CardWidget(
            title: "Payments",
            routeName: "",
            imagePath: "assets/img/payment.png",
            isDarkMode: isDarkMode,
          ),
        ),
        Container(
          width: 120,
          height: 140,
          padding: const EdgeInsets.all(10),
          child: CardWidget(
            title: "Staffs",
            routeName: "/staffdetails",
            imagePath: "assets/img/medicalteam.png",
            isDarkMode: isDarkMode,
          ),
        ),
      ],
    );
  }
}
