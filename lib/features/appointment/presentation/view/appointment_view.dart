import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_sizes.dart';
import '../../../../config/constants/text_strings.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: AppColors.whiteText,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          AppTexts.appointmentPageTitle.toUpperCase(),
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
                        height: AppSizes.spaceBtwSections,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                          onPressed: () {},
                          child: Text(AppTexts.bookAppointment.toUpperCase()),
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
