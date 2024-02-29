import 'package:age_care/config/constants/api_endpoints.dart';
import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/features/profile/data/model/profile_api_model.dart';
import 'package:age_care/features/profile/domain/entity/profile_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../core/common/provider/secure_storage_provide.dart';
import '../../../../core/network/http_service.dart';

final profileRemoteDataSourceProvider = Provider<ProfileRemoteDataSource>(
  (ref) => ProfileRemoteDataSource(
    secureStorage: ref.read(flutterSecureStorageProvider),
    dio: ref.read(httpServiceProvider),
  ),
);

class ProfileRemoteDataSource {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  ProfileRemoteDataSource({required this.dio, required this.secureStorage});

  //Get User Profile by userId

  Future<Either<Failure, List<ProfileEntity>>> getProfile(String userId) async {
    try {
      final token = await secureStorage.read(key: "authToken");
      if (token == null) {
        return Left(Failure(error: "Token not found"));
      }

      final decodedToken = JwtDecoder.decode(token);
      final userId = decodedToken['id'];
      if (userId == null) {
        return Left(Failure(error: "User ID not found in token"));
      }

      Response response = await dio.get(
        '${ApiEndpoints.profile}/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data;
        if (responseData.containsKey("userProfile")) {
          var userJsonList = responseData["userProfile"] as List<dynamic>;
          List<ProfileEntity> user = userJsonList
              .map((users) => ProfileApiModel.fromJson(users).toEntity())
              .toList();
          return Right(user);
        } else {
          return Left(Failure(error: "User profile not found in response"));
        }
      } else {
        return Left(
          Failure(
            error: response.statusMessage ?? "Failed to get profile",
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return Left(Failure(error: "Connection timeout. Please try again."));
      } else if (e.type == DioExceptionType.badResponse) {
      } else {
        return Left(Failure(error: "Server error. Please try again later."));
      }
      Left(Failure(error: "An unexpected error occurred."));
    }
    throw Exception("An unexpected error occurred in getProfile");
  }
}
