import 'package:age_care/config/router/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../config/constants/app_colors.dart';
import '../../../../../config/constants/app_sizes.dart';
import '../../../../../config/constants/text_strings.dart';
import '../../../../../core/utils/helpers/helper_functions.dart';
import '../../../domain/entity/appointment_entity.dart';
import '../../viewmodel/appointment_viewmodel.dart';
import 'package:intl/intl.dart';

class AppointmentView extends ConsumerStatefulWidget {
  const AppointmentView({Key? key}) : super(key: key);

  @override
  ConsumerState<AppointmentView> createState() => _AppointmentViewState();
}

class _AppointmentViewState extends ConsumerState<AppointmentView> {
  final _key = GlobalKey<FormState>();
  final serviceTypeController = TextEditingController();
  final _serviceDateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  final _locationFocusNode = FocusNode();

  @override
  List<String> services = [
    'Nursing',
    'Personal Care',
    'Age Care',
    'Therapy',
    'Dental Care'
  ];
  String selectedService = '';

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final DateTime? selectDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectDate != null) {
      final formattedDate =
          DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(selectDate);
      print('Formatted Date: $formattedDate');
      controller.text = formattedDate;
    }
  }

  Future<void> _selectTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final TimeOfDay? selectTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectTime != null) {
      final formattedTime = DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(
        DateTime(2024, 1, 1, selectTime.hour, selectTime.minute),
      );
      print('Formatted Time: $formattedTime');
      controller.text = formattedTime;
    }
  }

  //Bottom Modal Sheet for Confirmation
  void _showConfirmationModal(BuildContext context) {
    bool isAnyFieldNull = false;
    bool isDarkMode = HelperFunctions.isDarkMode(context);

    //check if any field is empty
    if (selectedService.isEmpty ||
        _serviceDateController.text.isEmpty ||
        _startTimeController.text.isEmpty ||
        _endTimeController.text.isEmpty ||
        _locationController.text.isEmpty) {
      isAnyFieldNull = true;
    }
    showModalBottomSheet(
      elevation: 10,
      showDragHandle: false,
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: Duration(milliseconds: 500),
      ),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: 500,
            color: isDarkMode ? AppColors.dark : AppColors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: AppSizes.spaceBtwnInputFields,
                  ),
                  Text(
                    'Please Review Your Appointment Details',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwnInputFields,
                  ),
                  //Service Type
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Service Type:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          selectedService.isNotEmpty ? selectedService : 'N/A',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Service Date
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Service Date:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _serviceDateController.text.isNotEmpty
                              ? _serviceDateController.text
                              : 'N/A',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Start Time
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Start Time:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _startTimeController.text.isNotEmpty
                              ? _startTimeController.text
                              : 'N/A',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //End Time
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'End Time:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _endTimeController.text.isNotEmpty
                              ? _endTimeController.text
                              : 'N/A',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.error,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  //Location
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Location:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _locationController.text.isNotEmpty
                              ? _locationController.text
                              : 'N/A',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Notes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Notes:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _notesController.text.isNotEmpty
                              ? _notesController.text
                              : 'N/A',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (isAnyFieldNull)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Please Fill All Fields To Proceed!',
                        style: TextStyle(
                          color: AppColors.error,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  SizedBox(
                    height: AppSizes.spaceBtwSections,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isAnyFieldNull
                              ? null
                              : () async {
                                  final formState = _key.currentState;
                                  if (formState != null &&
                                      formState.mounted &&
                                      formState.validate()) {
                                    final entity = AppointmentEntity(
                                      serviceType: selectedService,
                                      serviceDate: _serviceDateController.text,
                                      startTime: _startTimeController.text,
                                      endTime: _endTimeController.text,
                                      location: _locationController.text,
                                      notes: _notesController.text,
                                    );
                                    ref
                                        .read(appointmentViewModelProvider
                                            .notifier)
                                        .bookAppointment(entity, context);
                                  }
                                },
                          child: Text('Confirm'),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: AppColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppSizes.spaceBtwnInputFields,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.error,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //_requestLocationPermission();
    });
  }

  @override
  void dispose() {
    _locationFocusNode.dispose();
    super.dispose();
  }

  Future<void> _requestLocationPermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      // Location permission granted
    } else {
      var status = await Permission.locationWhenInUse.request();
      if (status.isGranted) {
        // Location permission granted
      } else if (status.isDenied) {
        // Handle permission denied
      } else if (status.isPermanentlyDenied) {
        // Open app settings if permission is permanently denied
        openAppSettings();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.watch(appointmentViewModelProvider).showMessage!) {
        EasyLoading.showSuccess('Appointment Booked Successfully',
            dismissOnTap: false);
        ref.read(appointmentViewModelProvider.notifier).resetMessage(false);
      }
    });

    final isDarkMode = HelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.dark : AppColors.whiteText,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: isDarkMode ? AppColors.dark : AppColors.primaryColor,
        title: Text(
          AppTexts.bookAppointment.toUpperCase(),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          // padding: EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
          child: Column(
            children: [
              Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      DropdownButtonFormField(
                        key: ValueKey('serviceType'),
                        decoration: InputDecoration(
                          labelText: 'Service Type',
                          hintText: 'Select Service',
                        ),
                        value:
                            selectedService.isNotEmpty ? selectedService : null,
                        items: services.map((service) {
                          return DropdownMenuItem(
                            value: service,
                            child: Text(service),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedService = value.toString();
                          });
                        },
                      ),
                      const SizedBox(height: AppSizes.spaceBtwnInputFields),
                      TextFormField(
                        key: ValueKey('serviceDate'),
                        controller: _serviceDateController,
                        decoration: InputDecoration(
                          labelText: 'Service Date',
                          hintText: 'YYYY-MM-DD',
                          suffixIcon: Icon(Iconsax.calendar_2),
                        ),
                        onTap: () {
                          _selectDate(context, _serviceDateController);
                        },
                      ),
                      const SizedBox(
                        height: AppSizes.spaceBtwnInputFields,
                      ),
                      TextFormField(
                        key: ValueKey('startTime'),
                        controller: _startTimeController,
                        decoration: InputDecoration(
                          labelText: 'Start Time',
                          hintText: '00:00',
                          suffixIcon: Icon(Iconsax.clock),
                        ),
                        onTap: () {
                          _selectTime(context, _startTimeController);
                        },
                      ),
                      const SizedBox(
                        height: AppSizes.spaceBtwnInputFields,
                      ),
                      TextFormField(
                        key: ValueKey('endTime'),
                        controller: _endTimeController,
                        decoration: InputDecoration(
                          labelText: 'End Time',
                          hintText: '00:00',
                          suffixIcon: Icon(Iconsax.clock),
                        ),
                        onTap: () {
                          _selectTime(context, _endTimeController);
                        },
                      ),
                      const SizedBox(
                        height: AppSizes.spaceBtwnInputFields,
                      ),
                      TextFormField(
                        key: ValueKey('location'),
                        controller: _locationController,
                        decoration: InputDecoration(
                          labelText: 'Location',
                          hintText: 'Search Location',
                          suffixIcon: Icon(Iconsax.location),
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.spaceBtwnInputFields,
                      ),
                      TextFormField(
                        key: ValueKey('notes'),
                        controller: _notesController,
                        decoration: InputDecoration(
                          labelText: 'Notes',
                          hintText: 'Add Notes',
                          suffixIcon: Icon(Iconsax.note),
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: AppSizes.spaceBtwSections,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                          onPressed: () {
                            _showConfirmationModal(context);
                          },
                          child: Text(AppTexts.bookAppointment.toUpperCase()),
                        ),
                      ),
                      SizedBox(
                        height: AppSizes.spaceBtwnInputFields,
                      ),
                      //View All Appointments
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: BorderSide(
                              color: isDarkMode
                                  ? AppColors.white
                                  : AppColors.primaryColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, MyRoutes.viewbookedappointment);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "View All Appointments",
                                style: TextStyle(
                                  color: isDarkMode
                                      ? AppColors.white
                                      : AppColors.primaryColor,
                                ),
                              ),
                              Icon(
                                Icons.file_copy,
                                color: isDarkMode
                                    ? AppColors.white
                                    : AppColors.primaryColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
