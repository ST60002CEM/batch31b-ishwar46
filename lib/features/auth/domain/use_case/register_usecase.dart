import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/auth_entity.dart';
import '../repository/auth_repository.dart';

final registerUseCaseProvider = Provider.autoDispose<RegisterUseCase>(
  (ref) => RegisterUseCase(ref.read(authRepositoryProvider)),
);

class RegisterUseCase {
  final IAuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  Future<Either<Failure, bool>> registerStaff(AuthEntity entity) async {
    return await _authRepository.registerStaff(entity);
  }
}
