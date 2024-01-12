import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/features/staffs/data/repository/staff_remote_repo_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entity/staff_entity.dart';

final staffRepositoryProvider = Provider.autoDispose<IStaffRepository>(
  (ref) {
    return ref.read(staffRemoteRepositoryProvider);
  },
);

abstract class IStaffRepository {
  Future<Either<Failure, List<StaffEntity>>> getAllStaff();
}
