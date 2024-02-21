import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/features/userprofile/domain/entity/user_entity.dart';
import 'package:age_care/features/userprofile/domain/reository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final GetUserProfileUsecaseProvider =
    Provider.autoDispose<GetUserProfileUsecase>((ref) => GetUserProfileUsecase(
        repository: ref.read(userProfileRepositoryProvider)));

class GetUserProfileUsecase {
  final IUserProfileRepository repository;

  GetUserProfileUsecase({required this.repository});

  Future<Either<Failure, List<UserEntity>>> getUserProfile(String userId) {
    return repository.getUserProfile(
      userId,
    );
  }
}
