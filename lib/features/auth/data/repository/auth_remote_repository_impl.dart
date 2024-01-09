import 'dart:io';

import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:age_care/features/auth/domain/entity/auth_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repository/auth_repository.dart';

final authRemoteRepositoryProvider = Provider<IAuthRepository>(
  (ref) => AuthRemoteRepository(
    ref.read(authRemoteDataSourceProvider),
  ),
);

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);

  @override
  Future<Either<Failure, bool>> loginStaff(String username, String password) {
    // TODO: implement loginStaff
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> registerStaff(AuthEntity staff) async {
    return await _authRemoteDataSource.registerStaff(staff);
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
