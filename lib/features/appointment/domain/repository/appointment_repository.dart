import 'package:age_care/features/appointment/data/repository/appointment_remote_repository_impl.dart';
import 'package:age_care/features/appointment/domain/entity/appointment_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';

final appointmentRepositoryProvider = Provider<IAppointmentRepository>(
  (ref) => ref.read(appointmentRemoteRepositoryProvider),
);

abstract class IAppointmentRepository {
  Future<Either<Failure, bool>> createAppointment(
      AppointmentEntity appointment);
  Future<Either<Failure, List<AppointmentEntity>>> getAllAppointments();
  Future<Either<Failure, bool>> updateAppointment(
      AppointmentEntity appointment);
  Future<Either<Failure, bool>> deleteAppointment(String id);
  Future<Either<Failure, bool>> cancelAppointment(String id);
}