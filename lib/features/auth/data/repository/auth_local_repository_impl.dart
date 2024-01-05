import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/auth_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../data_source/auth_local_data_source.dart';

final authLocalRepositoryProvider = Provider.autoDispose<IAuthRepository>(
  (ref) => AuthLocalRepository(ref.read(authLocalDataSourceProvider)),
);

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, bool>> loginStaff(String username, String password) {
    return _authLocalDataSource.loginStaff(username, password);
  }

  @override
  Future<Either<Failure, bool>> registerStaff(AuthEntity staff) {
    return _authLocalDataSource.registerStaff(staff);
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return const Right("");
  }
}
