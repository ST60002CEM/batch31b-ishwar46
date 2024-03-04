import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/profile_entity.dart';
import '../repository/profile_repository.dart';

final editProfileUseCaseProvider = Provider.autoDispose<EditProfileUseCase>(
    (ref) => EditProfileUseCase(ref.watch(profileRepositoryProvider)));

class EditProfileUseCase {
  final IProfileRepository _profileRepository;

  EditProfileUseCase(this._profileRepository);

  Future<Either<Failure, ProfileEntity>> editProfile(ProfileEntity user) {
    return _profileRepository.editProfile(user);
  }
}
