import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/appointment_entity.dart';
import '../repository/appointment_repository.dart';

final viewAppointmentUseCaseProvider =
    Provider.autoDispose<ViewAppointmentUseCase>(
  (ref) => ViewAppointmentUseCase(ref.read(appointmentRepositoryProvider)),
);

class ViewAppointmentUseCase {
  final IAppointmentRepository _appointmentRepository;

  ViewAppointmentUseCase(this._appointmentRepository);

  Future<Either<Failure, List<AppointmentEntity>>> getAppointments() async {
    return await _appointmentRepository.getAppointments();
  }
}
