import 'package:age_care/features/profile/domain/entity/profile_entity.dart';
import 'package:age_care/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';

final getProfileUseCaseProvider = Provider.autoDispose<GetProfileUseCase>(
    (ref) => GetProfileUseCase(ref.watch(profileRepositoryProvider)));

class GetProfileUseCase {
  final IProfileRepository _profileRepostiory;

  GetProfileUseCase(this._profileRepostiory);

  // Future<void> getProfile(String userId) {
  //   return _profileRepostiory.getProfile(userId);
  // }

  Future<Either<Failure, List<ProfileEntity>>> getProfile() async {
    return _profileRepostiory.getProfile();
  }
}
