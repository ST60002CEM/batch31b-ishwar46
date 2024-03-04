import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/features/profile/data/data_source/profile_local_data_source.dart';
import 'package:age_care/features/profile/domain/entity/profile_entity.dart';
import 'package:age_care/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileLocalRepoProvider = Provider<IProfileRepository>((ref) {
  return ProfileLocalRepositoryImpl(
      profileLocalDataSource: ref.read(profileLocalDataSourceProvider));
});

class ProfileLocalRepositoryImpl implements IProfileRepository {
  final ProfileLocalDataSource profileLocalDataSource;

  ProfileLocalRepositoryImpl({
    required this.profileLocalDataSource,
  });

  @override
  Future<Either<Failure, ProfileEntity>> editProfile(ProfileEntity users) {
    // TODO: implement editProfile
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<ProfileEntity>>> getProfile() {
    // TODO: implement getProfile
    throw UnimplementedError();
  }
}
