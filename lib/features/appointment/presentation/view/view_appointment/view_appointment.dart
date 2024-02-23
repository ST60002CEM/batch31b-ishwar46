import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/constants/app_colors.dart';
import '../../../../../config/constants/text_strings.dart';
import '../../viewmodel/appointment_viewmodel.dart';
import '../../widgets/appointments_card_widget.dart';

class ViewBookedAppointments extends ConsumerStatefulWidget {
  const ViewBookedAppointments({Key? key}) : super(key: key);

  @override
  _ViewBookedAppointmentsState createState() => _ViewBookedAppointmentsState();
}

class _ViewBookedAppointmentsState
    extends ConsumerState<ViewBookedAppointments> {
  TextEditingController searchController = TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
            Expanded(
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _refreshData,
                child: Consumer(
                  builder: (context, ref, child) {
                    final state = ref.watch(appointmentViewModelProvider);
                    if (state.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state.error != null) {
                      return Center(child: Text(state.error!));
                    } else if (state.appointments == null ||
                        state.appointments!.isEmpty) {
                      return Center(child: Text('No appointments found'));
                    } else {
                      return ListView.builder(
                        itemCount: state.appointments!.length,
                        itemBuilder: (context, index) {
                          final appointment = state.appointments![index];
                          return AppointmentCard(
                            serviceType: appointment.serviceType,
                            serviceDate: appointment.serviceDate,
                            startTime: appointment.startTime,
                            endTime: appointment.endTime,
                            location: appointment.location,
                            notes: appointment.notes,
                            ticketnumber: appointment.ticketNumber,
                            status: appointment.status,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _refreshData() async {
    final state = ref.read(appointmentViewModelProvider);

    await Future.delayed(Duration(seconds: 2));

    setState(() {});
  }
}
