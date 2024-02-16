import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/features/appointment/domain/entity/appointment_entity.dart';
import 'package:age_care/features/appointment/domain/repository/appointment_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appointmentRemoteRepositoryProvider = Provider<IAppointmentRepository>(
  (ref) => AppointmentRemoteRepository(
      // ref.read(appointmentRemoteDataSourceProvider),

      ),
);

class AppointmentRemoteRepository implements IAppointmentRepository {
  @override
  Future<Either<Failure, bool>> cancelAppointment(String id) {
    // TODO: implement cancelAppointment
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> createAppointment(
      AppointmentEntity appointment) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteAppointment(String id) {
    // TODO: implement deleteAppointment
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<AppointmentEntity>>> getAllAppointments() {
    // TODO: implement getAllAppointments
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updateAppointment(
      AppointmentEntity appointment) {
    // TODO: implement updateAppointment
    throw UnimplementedError();
  }
}
