import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../../config/constants/app_colors.dart';
import '../../../../../config/constants/app_sizes.dart';
import '../../../../../config/constants/text_strings.dart';

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

  List<String> services = ['Service 1', 'Service 2', 'Service 3'];
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
      final formattedDate = DateFormat('yyyy-MM-dd').format(selectDate);
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
      final formattedTime = DateFormat('HH:mm').format(
        DateTime(2024, 1, 1, selectTime.hour, selectTime.minute),
      );
      controller.text = formattedTime;
    }
  }

  //Bottom Modal Sheet for Confirmation
  void _showConfirmationModal(BuildContext context) {
    bool isAnyFieldNull = false;

    //check if any field is empty
    if (selectedService.isEmpty ||
        _serviceDateController.text.isEmpty ||
        _startTimeController.text.isEmpty ||
        _endTimeController.text.isEmpty ||
        _locationController.text.isEmpty) {
      isAnyFieldNull = true;
    }
    showModalBottomSheet(
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: Duration(milliseconds: 500),
      ),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            height: 500,
            color: AppColors.white,
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
                              : () {
                                  EasyLoading.show(
                                    status: 'Booking Appointment...',
                                    maskType: EasyLoadingMaskType.black,
                                  );
                                  Future.delayed(Duration(seconds: 2), () {
                                    EasyLoading.dismiss();
                                    EasyLoading.showSuccess(
                                      'Appointment Booked Successfully!',
                                    );
                                    Navigator.pushReplacementNamed(
                                        context, '/home');
                                  });
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
          child: Column(
            children: [
              Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      DropdownButtonFormField(
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
                              color: AppColors.primaryColor,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/viewbookedappointment');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "View All Appointments",
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              Icon(
                                Icons.file_copy,
                                color: AppColors.primaryColor,
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
