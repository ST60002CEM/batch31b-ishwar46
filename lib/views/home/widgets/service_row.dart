import 'package:flutter/widgets.dart';

import '../../../widgets/card_widget.dart';

class ServiceRow extends StatelessWidget {
  const ServiceRow({
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
            title: "Appointment",
            routeName: "/appointmentspage",
            imagePath: "assets/img/appointment.png",
          ),
        ),
        Container(
          width: 120,
          height: 140,
          padding: const EdgeInsets.all(10),
          child: const CardWidget(
            title: "Health Care",
            routeName: "/settings",
            imagePath: "assets/img/doctor.png",
          ),
        ),
        Container(
          width: 120,
          height: 140,
          padding: const EdgeInsets.all(10),
          child: const CardWidget(
            title: "Staffs",
            routeName: "/staffdetails",
            imagePath: "assets/img/medicalteam.png",
          ),
        ),
      ],
    );
  }
}
