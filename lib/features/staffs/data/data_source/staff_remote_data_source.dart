import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/features/staffs/domain/entity/staff_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/network/http_service.dart';
import '../../../auth/data/data_source/auth_remote_data_source.dart';
import '../dto/get_all_staff_dto.dart';
import '../model/staff_api_model.dart';

final staffRemoteDatasourceProvider =
    Provider.autoDispose<StaffRemoteDataSource>(
  (ref) => StaffRemoteDataSource(
    dio: ref.read(httpServiceProvider),
  ),
);

class StaffRemoteDataSource {
  final Dio dio;

  StaffRemoteDataSource({required this.dio});

  //Get all Staffs
  Future<Either<Failure, List<StaffEntity>>> getAllStaff() async {
    try {
      var response = await dio.get(ApiEndpoints.allstaff);
      if (response.statusCode == 200) {
        GetAllStaffDTO staffAddDTO = GetAllStaffDTO.fromJson(response.data);

        List<StaffEntity> staffList = staffAddDTO.data
            .map((staff) => StaffAPIModel.toEntity(staff))
            .toList();

        return Right(staffList);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }

  Future<Either<Failure, bool>> deleteStaff(String staffId) async {
    try {
      FlutterSecureStorage _storage = FlutterSecureStorage();

      String? token = await _storage.read(key: 'token');

      if (token != null) {
        dio.options.headers['Authorization'] = 'Bearer $token';
      } else {
        return Left(Failure(error: 'Authorization token not available'));
      }

      var response = await dio.delete(ApiEndpoints.deletestaff + staffId);

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(error: e.response?.data['message']));
    }
  }
}
