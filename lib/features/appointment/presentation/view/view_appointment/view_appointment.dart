import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../config/constants/app_colors.dart';
import '../../../../../config/constants/text_strings.dart';
import '../../viewmodel/appointment_viewmodel.dart';
import '../../widgets/appointments_card_widget.dart';
import '../book_appointment/appointment_book_view.dart';

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        splashColor: AppColors.white,
        onPressed: () {
          Navigator.of(context).push(_createRoute());
        },
        child: Icon(Icons.add, color: AppColors.white),
      ),
    );
  }

  Future<void> _refreshData() async {
    final state = ref.read(appointmentViewModelProvider);

    await Future.delayed(Duration(seconds: 2));

    setState(() {});
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        AppointmentView(), // Replace AppointmentsPage with your desired destination page
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-1.0, 0.0); // Slide from left
      var end = Offset.zero;
      var curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
