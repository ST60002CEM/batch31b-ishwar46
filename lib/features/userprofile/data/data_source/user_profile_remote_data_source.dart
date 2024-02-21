import 'package:age_care/config/constants/api_endpoints.dart';
import 'package:age_care/core/common/provider/secure_storage_provide.dart';
import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/core/network/http_service.dart';
import 'package:age_care/features/userprofile/data/model/user_profile_api_model.dart';
import 'package:age_care/features/userprofile/domain/entity/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../dto/get_user_profile_dto.dart';

final userProfileRemoteDataSourceProvider =
    Provider.autoDispose<UserProfileRemoteDataSource>((ref) =>
        UserProfileRemoteDataSource(
            dio: ref.read(httpServiceProvider),
            secureStorage: ref.read(flutterSecureStorageProvider)));

class UserProfileRemoteDataSource {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  UserProfileRemoteDataSource({required this.dio, required this.secureStorage});

  Future<Either<Failure, List<UserEntity>>> getUserProfile(userId) async {
    try {
      final token = await secureStorage.read(key: "authToken");

      print("Token: $token");

      if (token == null) {
        return Left(Failure(error: "Token not found"));
      }

      final decodedToken = JwtDecoder.decode(token);
      print("Decoded Token: $decodedToken");
      final tokenUserId = decodedToken['id'];

      if (tokenUserId == null) {
        return Left(Failure(error: "Token not found"));
      }

      var response = await dio.get('${ApiEndpoints.profile}/$userId',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      print("Response: ${response.data}");

      if (response.statusCode == 200) {
        GetUserProfileDTO userAddDTO =
            GetUserProfileDTO.fromJson(response.data);

        List<UserEntity> userList = userAddDTO.data
            .map((user) => UserProfileAPIModel.toEntity(user))
            .toList();

        return Right(userList);
      } else {
        return Left(Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      print("DioException: $e");
      print("Error Response: ${e.response}");
      return Left(Failure(error: e.response?.data['message']));
    }
  }
}
