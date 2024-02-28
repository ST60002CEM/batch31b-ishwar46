import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/core/network/http_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoints.dart';

final otpRemoteDataSourceProvider = Provider<OTPRemoteDataSource>(
  (ref) => OTPRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class OTPRemoteDataSource {
  final Dio dio;

  OTPRemoteDataSource({required this.dio});

  // Send OTP to email
  Future<Either<Failure, bool>> sendOTP(String email) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.sendOTP,
        data: {"email": email},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return Left(Failure(error: "Connection timeout. Please try again."));
      } else if (e.type == DioExceptionType.badResponse) {
        return Left(Failure(error: "Server error. Please try again later."));
      } else {
        return Left(Failure(error: "An unexpected error occurred."));
      }
    } catch (e) {
      return Left(Failure(error: "An unexpected error occurred."));
    }
  }
}
