import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/features/staffs/data/data_source/staff_remote_data_source.dart';
import 'package:age_care/features/staffs/domain/entity/staff_entity.dart';
import 'package:age_care/features/staffs/domain/repository/staff_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final staffRemoteRepositoryProvider =
    Provider.autoDispose<IStaffRepository>((ref) {
  return StaffRemoteRepoImpl(ref.read(staffRemoteDatasourceProvider));
});

class StaffRemoteRepoImpl implements IStaffRepository {
  final StaffRemoteDataSource staffRemoteDataSource;

  const StaffRemoteRepoImpl(this.staffRemoteDataSource);

  @override
  Future<Either<Failure, List<StaffEntity>>> getAllStaff({
    required int page,
  }) async {
    try {
      final result = await staffRemoteDataSource.getAllStaff(page);

      return result.fold(
        (failure) => Left(failure),
        (staffList) => Right(staffList),
      );
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
