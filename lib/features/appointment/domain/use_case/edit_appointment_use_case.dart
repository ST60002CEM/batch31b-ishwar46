import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/appointment_entity.dart';
import '../repository/appointment_repository.dart';

final editAppointmentUseCaseProvider =
    Provider.autoDispose<EditAppointmentUseCase>(
  (ref) => EditAppointmentUseCase(ref.read(appointmentRepositoryProvider)),
);

class EditAppointmentUseCase {
  final IAppointmentRepository _appointmentRepository;

  EditAppointmentUseCase(this._appointmentRepository);

  Future<void> editAppointment(
      String appointmentId, AppointmentEntity updatedAppointment) async {
    await _appointmentRepository.editAppointment(
        appointmentId, updatedAppointment);
  }
}
