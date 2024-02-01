import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_sizes.dart';
import '../../../../config/constants/text_strings.dart';

class AppointmentView extends ConsumerStatefulWidget {
  const AppointmentView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AppointmentViewState();
}

class _AppointmentViewState extends ConsumerState<AppointmentView> {
  final _key = GlobalKey<FormState>();
  final serviceTypeController = TextEditingController();
  final _serviceDateController = TextEditingController();
  final _StartTimeController = TextEditingController();
  final _EndTimeController = TextEditingController();
  final _locationController = TextEditingController();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? selectDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (selectDate != null) {
      final formattedDate = DateFormat('yyyy-MM-dd').format(selectDate);
      controller.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar
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

      //Body

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
                      //Select Service
                      TextFormField(
                        controller: serviceTypeController,
                        decoration: InputDecoration(
                          labelText: '',
                          hintText: '',
                          suffixIcon: Icon(Iconsax.activity),
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(height: AppSizes.spaceBtwnInputFields),
                      //Service Date
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

                      //start time
                      TextFormField(
                        controller: _StartTimeController,
                        decoration: InputDecoration(
                          labelText: 'Start Time',
                          hintText: '00:00',
                          suffixIcon: Icon(Iconsax.clock),
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.spaceBtwnInputFields,
                      ),
                      //End Time Check Box
                      TextFormField(
                        controller: _EndTimeController,
                        decoration: InputDecoration(
                          labelText: 'End Time',
                          hintText: '00:00',
                          suffixIcon: Icon(Iconsax.clock),
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.spaceBtwnInputFields,
                      ),
                      //Location
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                            labelText: 'Location', hintText: 'Search Location'),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),

      //Column

      //Form

      //Button
    );
  }
}
