import 'package:age_care/features/appointment/domain/entity/appointment_entity.dart';
import 'package:age_care/features/appointment/domain/use_case/book_appointment_usecase.dart';
import 'package:age_care/features/appointment/domain/use_case/view_appointment_usecase.dart';
import 'package:age_care/features/appointment/presentation/state/appointment_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_routes.dart';
import '../../domain/use_case/delete_appointment_usecase.dart';

final appointmentViewModelProvider =
    StateNotifierProvider<AppointmentViewModel, AppointmentState>((ref) =>
        AppointmentViewModel(
            ref.read(bookAppointmentUseCaseProvider),
            ref.read(viewAppointmentUseCaseProvider),
            ref.read(deleteAppointmentUseCaseProvider)));

class AppointmentViewModel extends StateNotifier<AppointmentState> {
  final BookAppointmentUseCase _bookAppointmentUseCase;
  final ViewAppointmentUseCase _viewAppointmentUseCase;
  final DeleteAppointmentUseCase _deleteAppointmentUseCase;

  AppointmentViewModel(this._bookAppointmentUseCase,
      this._viewAppointmentUseCase, this._deleteAppointmentUseCase)
      : super(AppointmentState.initial()) {
    getAppointments();
  }

  Future<void> bookAppointment(
      AppointmentEntity entity, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    final result = await _bookAppointmentUseCase.bookAppointment(entity);
    state = state.copyWith(isLoading: false);

    result.fold(
      (failure) {
        EasyLoading.showError('Failed to Book Appointment: ${failure.error}');
      },
      (success) async {
        EasyLoading.showSuccess('Appointment Booked Successfully',
            dismissOnTap: false);
        state = state.copyWith(showMessage: true);
        await getAppointments();
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(
              context, MyRoutes.viewbookedappointment);
        });
      },
    );
  }

  Future<void> getAppointments() async {
    state = state.copyWith(isLoading: true);
    final result = await _viewAppointmentUseCase.getAppointments();
    state = state.copyWith(isLoading: false);

    result.fold(
      (failure) {
        state = state.copyWith(error: failure.error);
      },
      (appointments) {
        state = state.copyWith(appointments: appointments);
      },
    );
  }

  //DELETE APPOINTMENT
  Future<void> deleteAppointment(String appointmentId) async {
    state = state.copyWith(isLoading: true);
    try {
      await _deleteAppointmentUseCase.deleteAppointment(appointmentId);
      state = state.copyWith(isLoading: false, showMessage: false);
      EasyLoading.showSuccess('Appointment Deleted Successfully',
          dismissOnTap: false);
      await getAppointments();
    } catch (error) {
      EasyLoading.showError('Failed to Delete Appointment: $error');
      state = state.copyWith(isLoading: false);
    }
  }

  void reset() {
    state = state.copyWith(
      isLoading: false,
      error: null,
      showMessage: false,
    );
  }

  void resetMessage(bool value) {
    state = state.copyWith(showMessage: value);
  }
}
