import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/features/appointment/domain/entity/appointment_entity.dart';
import 'package:age_care/features/appointment/domain/repository/appointment_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_source/appointment_remote_data_source.dart';

final appointmentRemoteRepositoryProvider = Provider<IAppointmentRepository>(
  (ref) => AppointmentRemoteRepository(
    ref.read(appointmentRemoteDataSourceProvider),
  ),
);

class AppointmentRemoteRepository implements IAppointmentRepository {
  final AppointmentRemoteDataSource _appointmentRemoteDataSource;

  AppointmentRemoteRepository(this._appointmentRemoteDataSource);
  @override
  Future<Either<Failure, bool>> bookAppointment(AppointmentEntity appointment) {
    return _appointmentRemoteDataSource.createAppointment(appointment);
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAppointments() {
    return _appointmentRemoteDataSource.getAppointments();
  }

  @override
  Future<Either<Failure, bool>> deleteAppointment(String appointmentId) {
    return _appointmentRemoteDataSource.deleteAppointment(appointmentId);
  }

  @override
  Future<Either<Failure, bool>> editAppointment(
      String appointmentId, AppointmentEntity updatedAppointment) {
    return _appointmentRemoteDataSource.editAppointment(
        appointmentId, updatedAppointment);
  }
}
