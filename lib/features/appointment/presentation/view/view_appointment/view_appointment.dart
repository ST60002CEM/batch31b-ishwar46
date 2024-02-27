import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../../config/constants/app_colors.dart';
import '../../../../../config/constants/text_strings.dart';
import '../../../domain/entity/appointment_entity.dart';
import '../../viewmodel/appointment_viewmodel.dart';
import '../../widgets/appointments_card_widget.dart';
import '../../widgets/no_data.dart';
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
  bool isAdmin = false;

  void _showEditModal(BuildContext context, AppointmentEntity appointment) {
    TextEditingController serviceTypeController =
        TextEditingController(text: appointment.serviceType);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Appointment'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: serviceTypeController,
                  decoration: InputDecoration(labelText: 'Service Type'),
                  onChanged: (value) {
                    appointment.serviceType = value;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await ref
                    .read(appointmentViewModelProvider.notifier)
                    .editAppointment(appointment.appointmentId!, appointment);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    checkAdminStatus();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.watch(appointmentViewModelProvider.notifier).getAppointments();
    });
  }

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
                      return NoData();
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
                            isAdmin: isAdmin,
                            ticketnumber: appointment.ticketNumber,
                            status: appointment.status,
                            onDelete: () async {
                              await ref
                                  .read(appointmentViewModelProvider.notifier)
                                  .deleteAppointment(
                                      appointment.appointmentId!);
                            },
                            onEdit: () {
                              EasyLoading.showInfo(
                                  'Edit feature is coming soon');
                              // _showEditModal(context, appointment);
                            },
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
      floatingActionButton: FutureBuilder<bool>(
        future: checkAdminStatus(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            isAdmin = snapshot.data ?? false;
            return Visibility(
              visible: !isAdmin,
              child: FloatingActionButton(
                backgroundColor: AppColors.primaryColor,
                onPressed: () {
                  Navigator.of(context).push(_createRoute());
                },
                child: Icon(
                  Icons.add,
                  color: AppColors.white,
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Future<bool> checkAdminStatus() async {
    final secureStorage = FlutterSecureStorage();
    final token = await secureStorage.read(key: "authToken");
    if (token != null) {
      final decodedToken = JwtDecoder.decode(token);
      final isAdminValue = decodedToken['isAdmin'] ?? false;
      return isAdminValue;
    }
    return false;
  }

  Future<void> _refreshData() async {
    await ref.refresh(appointmentViewModelProvider);
    EasyLoading.showSuccess('Appointments Refreshed');
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AppointmentView(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(-1.0, 0.0);
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
