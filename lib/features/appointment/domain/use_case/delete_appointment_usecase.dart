import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/appointment_repository.dart';

final deleteAppointmentUseCaseProvider =
    Provider.autoDispose<DeleteAppointmentUseCase>(
  (ref) => DeleteAppointmentUseCase(ref.read(appointmentRepositoryProvider)),
);

class DeleteAppointmentUseCase {
  final IAppointmentRepository _appointmentRepository;
  DeleteAppointmentUseCase(this._appointmentRepository);

  Future<void> deleteAppointment(String appointmentId) async {
    await _appointmentRepository.deleteAppointment(appointmentId);
  }
}
