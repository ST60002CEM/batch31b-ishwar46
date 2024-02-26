import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/features/appointment/domain/repository/appointment_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/appointment_entity.dart';

final bookAppointmentUseCaseProvider =
    Provider.autoDispose<BookAppointmentUseCase>(
  (ref) => BookAppointmentUseCase(ref.read(appointmentRepositoryProvider)),
);

class BookAppointmentUseCase {
  final IAppointmentRepository _appointmentRepository;

  BookAppointmentUseCase(this._appointmentRepository);

  Future<Either<Failure, bool>> bookAppointment(
      AppointmentEntity appointment) async {
    return await _appointmentRepository.bookAppointment(appointment);
  }
}
