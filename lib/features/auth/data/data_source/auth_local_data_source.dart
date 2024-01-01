import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../../../core/network/hive_service.dart';
import '../../domain/entity/auth_entity.dart';
import '../model/auth_hive_model.dart';

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>(
  (ref) => AuthLocalDataSource(ref.watch(hiveServiceProvider)),
);

class AuthLocalDataSource {
  final HiveService _hiveService;

  AuthLocalDataSource(this._hiveService);

  Future<Either<Failure, bool>> registerStaff(AuthEntity entity) async {
    try {
      // Convert auth entity to auth hive model
      AuthHiveModel authHiveModel = AuthHiveModel.toHiveModel(entity);
      // Save auth hive model to hive
      await _hiveService.registerStaff(authHiveModel);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> loginStaff(
    String username,
    String password,
  ) async {
    try {
      // // Get all students from hive
      // List<AuthHiveModel> students = await _hiveService.getAllStudents();
      // // Find the student with the given username and password
      // AuthHiveModel? student = students.firstWhere(
      //   (student) =>
      //       student.username == username && student.password == password,
      // );
      // // If student is not null, return true
      // return const Right(true);
      _hiveService.loginStaff(username, password);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
