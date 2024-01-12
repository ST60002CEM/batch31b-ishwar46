import 'package:age_care/features/staffs/domain/entity/staff_entity.dart';
import 'package:age_care/features/staffs/domain/repository/staff_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';

final GetAllStaffUsecaseProvider = Provider.autoDispose<GetAllStaffUsecase>(
  (ref) => GetAllStaffUsecase(repository: ref.read(staffRepositoryProvider)),
);

class GetAllStaffUsecase {
  final IStaffRepository repository;

  GetAllStaffUsecase({required this.repository});

  Future<Either<Failure, List<StaffEntity>>> getAllStaff() async {
    return await repository.getAllStaff();
  }
}
