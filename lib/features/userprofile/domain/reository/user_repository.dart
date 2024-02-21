import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/features/userprofile/data/repository/user_profile_remote_repo_impl.dart';
import 'package:age_care/features/userprofile/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProfileRepositoryProvider =
    Provider.autoDispose<IUserProfileRepository>((ref) {
  return ref.read(userProfileRemoteRepositoryProvider);
});

abstract class IUserProfileRepository {
  Future<Either<Failure, List<UserEntity>>> getUserProfile(String userId);
}
