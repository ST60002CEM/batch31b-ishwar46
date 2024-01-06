import 'dart:io';

import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/features/auth/data/repository/auth_local_repository_impl.dart';
import 'package:age_care/features/auth/domain/entity/auth_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repository/auth_repository.dart';

final authRemoteRepositoryProvider = Provider<IAuthRepository>(
  (ref) => ref.read(authLocalRepositoryProvider),
);

class AuthRemoteDataSource implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteDataSource(this._authRemoteDataSource);

  @override
  Future<Either<Failure, bool>> loginStaff(String username, String password) {
    // TODO: implement loginStaff
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> registerStaff(AuthEntity staff) {
    // TODO: implement registerStaff
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

 
}
