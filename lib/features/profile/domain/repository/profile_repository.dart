import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/profile_remote_repo_impl.dart';
import '../entity/profile_entity.dart';

final profileRepositoryProvider = Provider<IProfileRepository>(
    ((ref) => ref.read(profileRemoteRepositoryProvider)));

abstract class IProfileRepository {
  Future<Either<Failure, List<ProfileEntity>>> getProfile(String userId);
}
