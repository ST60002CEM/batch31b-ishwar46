import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/provider/connection.dart';
import '../../../../core/failure/failure.dart';
import '../../data/repository/profile_local_repo_impl.dart';
import '../../data/repository/profile_remote_repo_impl.dart';
import '../entity/profile_entity.dart';

// final profileRepositoryProvider = Provider<IProfileRepository>(
//     ((ref) => ref.read(profileRemoteRepositoryProvider)));

final profileRepositoryProvider = Provider<IProfileRepository>(((ref) {
  final internetStatus = ref.watch(connectivityStatusProvider);
  if (ConnectivityStatus.isConnected == internetStatus) {
    //If internet is available, return remote repository
    return ref.read(profileRemoteRepositoryProvider);
  } else {
    //If internet is not available, return local repository
    return ref.read(profileLocalRepoProvider);
  }
}));

abstract class IProfileRepository {
  Future<Either<Failure, List<ProfileEntity>>> getProfile();
  Future<Either<Failure, ProfileEntity>> editProfile(ProfileEntity users);
}
