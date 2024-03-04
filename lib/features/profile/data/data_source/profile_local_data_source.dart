import 'package:age_care/core/network/local/hive_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/profile_entity.dart';
import '../model/profile_hive_model.dart';

//Dipendency Injection using RIverpod

final profileLocalDataSourceProvider = Provider<ProfileLocalDataSource>((ref) {
  return ProfileLocalDataSource(
    hiveService: ref.read(hiveServiceProvider),
    profileHiveModel: ref.read(profileHiveModelProvider),
  );
});

class ProfileLocalDataSource {
  final HiveService hiveService;
  final ProfileHiveModel profileHiveModel;

  ProfileLocalDataSource({
    required this.hiveService,
    required this.profileHiveModel,
  });

  //Get Profile
  Future<Either<Failure, List<ProfileEntity>>> getAllBatches() async {
    try {
      // Get profile from Hive
      final profile = await hiveService.getProfile();
      // Convert Hive Object to Entity
      final profileEntities = profileHiveModel.toEntityList(profile);
      return Right(profileEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
