import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../config/constants/app_colors.dart';
import '../../../../../config/constants/text_strings.dart';
import '../../widgets/appointments_card_widget.dart';

class ViewBookedAppointments extends ConsumerStatefulWidget {
  const ViewBookedAppointments({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewBookedAppointmentsState();
}

class _ViewBookedAppointmentsState
    extends ConsumerState<ViewBookedAppointments> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppColors.whiteText,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppTexts.viewBookedAppointment.toUpperCase(),
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
        leading: IconButton(
          color: AppColors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      //body
      //column
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //Search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                autocorrect: true,
                controller: searchController,
                decoration: InputDecoration(
                  labelText: AppTexts.searchAppointment,
                  hintText: AppTexts.search,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            //listview
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return AppointmentCard(
                    serviceType: 'Service 1',
                    serviceDate: '2024-02-06',
                    startTime: '11:00',
                    endTime: '13:00',
                    location: 'Kathmandu Nepal',
                    notes: 'Please bring your ID card for verification',
                    status: 2,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
