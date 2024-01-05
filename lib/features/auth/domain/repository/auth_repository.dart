import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../data/repository/auth_local_repository_impl.dart';
import '../entity/auth_entity.dart';

final authRepositoryProvider = Provider<IAuthRepository>(
  (ref) => ref.read(authLocalRepositoryProvider),
);

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerStaff(AuthEntity staff);
  Future<Either<Failure, bool>> loginStaff(String username, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
}
