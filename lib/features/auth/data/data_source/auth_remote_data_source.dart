import 'package:bcrypt/bcrypt.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/http_service.dart';
import '../../domain/entity/auth_entity.dart';
import '../model/auth_api_model.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSource(
    ref.read(httpServiceProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<Either<Failure, bool>> registerStaff(AuthEntity staff) async {
    try {
      AuthApiModel apiModel = AuthApiModel.fromEntity(staff);
      Response response = await dio.post(
        ApiEndpoints.register,
        data: {
          "firstName": apiModel.firstName,
          "lastName": apiModel.lastName,
          "email": apiModel.email,
          "phone": apiModel.phone,
          "username": apiModel.username,
          "password": apiModel.password,
          "address": apiModel.address,
        },
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  // Login User
  Future<Either<Failure, bool>> loginStaff(
      String username, String password) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        final userData = response.data['userData'];

        // Parse the token payload
        final decodedToken = JwtDecoder.decode(token);
        final tokenUsername = decodedToken['username'];

        print('Decoded Token: $decodedToken');
        print('Provided Username: $username');
        print('Token Username: $tokenUsername');

        // Compare provided username with token data
        if (username == tokenUsername) {
          // Store token
          await storeToken(token);
          return const Right(true);
        } else {
          // Username mismatch
          return Left(
            Failure(
              error: "Username mismatch",
              statusCode: response.statusCode.toString(),
            ),
          );
        }
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  // Token storage functions
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> storeToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }
}
