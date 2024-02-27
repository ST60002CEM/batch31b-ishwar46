import 'package:age_care/core/common/provider/secure_storage_provide.dart';
import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/core/network/http_service.dart';
import 'package:age_care/features/notifications/data/model/notification_api_model.dart';
import 'package:age_care/features/notifications/domain/entity/notification_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../../config/constants/api_endpoints.dart';

final notificationRemoteDataSourceProvider =
    Provider<NotifcationRemoteDataSource>(
  (ref) => NotifcationRemoteDataSource(
    ref.read(httpServiceProvider),
    ref.read(flutterSecureStorageProvider),
  ),
);

class NotifcationRemoteDataSource {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  NotifcationRemoteDataSource(this.dio, this.secureStorage);

  //get Notifications

  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
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
          '${ApiEndpoints.allnotifications}$userId',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200) {
        if (response.data.containsKey("notifications")) {
          var notificationsJsonList =
              response.data["notifications"] as List<dynamic>;
          List<NotificationEntity> notifications = notificationsJsonList
              .map((notifications) =>
                  NotificationApiModel.fromJson(notifications).toEntity())
              .toList();
          return Right(notifications);
        } else {
          return Left(
            Failure(
              error: "Notifications not found",
              statusCode: response.statusCode.toString(),
            ),
          );
        }
      } else {
        return Left(
          Failure(
            error: "Failed to get notifications",
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.error.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    }
  }
}
