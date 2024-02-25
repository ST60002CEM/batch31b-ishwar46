import 'package:age_care/features/appointment/data/repository/appointment_remote_repository_impl.dart';
import 'package:age_care/features/appointment/domain/entity/appointment_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';

final appointmentRepositoryProvider = Provider<IAppointmentRepository>(
  (ref) => ref.read(appointmentRemoteRepositoryProvider),
);

abstract class IAppointmentRepository {
  //Book Appointment
  Future<Either<Failure, bool>> bookAppointment(AppointmentEntity appointment);
  //Get Appointments
  Future<Either<Failure, List<AppointmentEntity>>> getAppointments();
  //Delete Appointment
  Future<Either<Failure, bool>> deleteAppointment(String appointmentId);
}
