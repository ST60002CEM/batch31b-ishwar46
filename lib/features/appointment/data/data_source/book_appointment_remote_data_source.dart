import 'package:age_care/core/common/provider/secure_storage_provide.dart';
import 'package:age_care/core/network/http_service.dart';
import 'package:age_care/features/appointment/data/model/appointment_api_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/failure/failure.dart';
import '../../domain/entity/appointment_entity.dart';

final appointmentRemoteDataSourceProvider =
    Provider<AppointmentRemoteDataSource>(
  (ref) => AppointmentRemoteDataSource(
    ref.read(httpServiceProvider),
    ref.read(flutterSecureStorageProvider),
  ),
);

class AppointmentRemoteDataSource {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  AppointmentRemoteDataSource(this.dio, this.secureStorage);

  Future<Either<Failure, bool>> createAppointment(
      AppointmentEntity appointment) async {
    try {
      // Retrieve token from secure storage
      final token = await secureStorage.read(key: "authToken");
      if (token == null) {
        return Left(Failure(error: "Token not found"));
      }

      // Decode token to extract userId
      final decodedToken = JwtDecoder.decode(token);
      final userId = decodedToken['id'];
      if (userId == null) {
        return Left(Failure(error: "User ID not found in token"));
      }

      AppointmentApiModel apiModel =
          AppointmentApiModel.fromEntity(appointment);

      Response response = await dio.post(
        ApiEndpoints.bookappointment,
        data: {
          "userId": userId,
          "serviceType": apiModel.serviceType,
          "serviceDate": apiModel.serviceDate,
          "startTime": apiModel.startTime,
          "endTime": apiModel.endTime,
          "location": apiModel.location,
          "notes": apiModel.notes,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
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
}
