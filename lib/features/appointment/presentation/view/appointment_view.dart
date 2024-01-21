import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/text_strings.dart';

class AppointmentView extends ConsumerStatefulWidget {
  const AppointmentView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AppointmentViewState();
}

class _AppointmentViewState extends ConsumerState<AppointmentView> {
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

      //Column

      //Form

      //Button
    );
  }
}
