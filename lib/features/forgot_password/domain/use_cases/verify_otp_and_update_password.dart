import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../repository/otp_repository.dart';

final verifyOTPandUpdateUseCaseProvider =
    Provider.autoDispose<VerifyOTPandUpdatePasswordUseCase>((ref) =>
        VerifyOTPandUpdatePasswordUseCase(ref.watch(otpRepositoryProvider)));

class VerifyOTPandUpdatePasswordUseCase {
  final IOTPRepository _otpRepository;

  VerifyOTPandUpdatePasswordUseCase(this._otpRepository);

  Future<Either<Failure, bool>> verifyandUpdateOTP(
      String email, String otp, String newPassword) {
    return _otpRepository.verifyandUpdateOTP(email, otp, newPassword);
  }
}
