import 'package:age_care/features/appointment/domain/entity/appointment_entity.dart';
import 'package:age_care/features/appointment/domain/use_case/book_appointment_usecase.dart';
import 'package:age_care/features/appointment/presentation/state/appointment_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_routes.dart';

final appointmentViewModelProvider =
    StateNotifierProvider<AppointmentViewModel, AppointmentState>((ref) =>
        AppointmentViewModel(ref.read(bookAppointmentUseCaseProvider)));

class AppointmentViewModel extends StateNotifier<AppointmentState> {
  final BookAppointmentUseCase _bookAppointmentUseCase;

  AppointmentViewModel(this._bookAppointmentUseCase)
      : super(AppointmentState.initial());

  Future<void> bookAppointment(
      AppointmentEntity entity, BuildContext context) async {
    state = state.copyWith(isLoading: true); // Set isLoading to true initially
    final result = await _bookAppointmentUseCase.bookAppointment(entity);
    state = state.copyWith(
        isLoading: false); // Set isLoading to false after operation completes

    result.fold((failure) {
      state = state.copyWith(error: failure.error); // Set the error message
      // Show error message using EasyLoading
      EasyLoading.showError('Failed to Book Appointment');
      // Dismiss EasyLoading
      EasyLoading.dismiss();
    }, (success) {
      if (success) {
        // Show success message using EasyLoading
        EasyLoading.showSuccess('Appointment Booked Successfully',
            dismissOnTap: false);
        // Trigger navigation after delay
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(
              context, MyRoutes.viewbookedappointment);
          // Dismiss EasyLoading after navigation
          EasyLoading.dismiss();
        });
      } else {
        // This block will execute if the appointment creation failed but didn't return an error
        EasyLoading.showError('Failed to Book Appointment');
        // Dismiss EasyLoading
        EasyLoading.dismiss();
      }
    });
  }
}
