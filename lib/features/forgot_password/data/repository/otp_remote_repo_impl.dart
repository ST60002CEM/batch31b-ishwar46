import 'package:age_care/core/failure/failure.dart';

import 'package:age_care/features/forgot_password/domain/repository/otp_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data_source/otp_remote_data_source.dart';

final otpRemoteRepositoryProvider = Provider<IOTPRepository>(
  (ref) => OTPRemoteRepository(ref.read(otpRemoteDataSourceProvider)),
);

class OTPRemoteRepository implements IOTPRepository {
  final OTPRemoteDataSource _otpRemoteDataSource;

  OTPRemoteRepository(this._otpRemoteDataSource);
  @override
  Future<Either<Failure, bool>> sendOTP(String email) {
    return _otpRemoteDataSource.sendOTP(email);
  }

  @override
  Future<Either<Failure, bool>> verifyandUpdateOTP(
      String email, String otp, String newPassword) {
    // TODO: implement verifyandUpdateOTP
    throw UnimplementedError();
  }
}
