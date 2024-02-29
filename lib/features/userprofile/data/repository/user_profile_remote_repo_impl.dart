import 'package:age_care/features/userprofile/data/data_source/user_profile_remote_data_source.dart';
import 'package:age_care/features/userprofile/domain/reository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/user_entity.dart';

final userProfileRemoteRepositoryProvider =
    Provider.autoDispose<IUserProfileRepository>((ref) {
  return UserRemoteRepoImpl(ref.read(userProfileRemoteDataSourceProvider));
});

class UserRemoteRepoImpl implements IUserProfileRepository {
  final UserProfileRemoteDataSource userProfileRemoteDataSource;

  const UserRemoteRepoImpl(this.userProfileRemoteDataSource);

  @override
  Future<Either<Failure, List<UserEntity>>> getUserProfile(String userId) {
    return userProfileRemoteDataSource.getUserProfile(userId);
  }
}
