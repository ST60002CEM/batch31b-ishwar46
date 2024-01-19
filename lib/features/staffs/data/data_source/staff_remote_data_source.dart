import 'package:age_care/core/failure/failure.dart';
import 'package:age_care/features/staffs/domain/entity/staff_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoints.dart';
import '../../../../core/network/http_service.dart';
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

  // Get all Staffs with pagination
  Future<Either<Failure, List<StaffEntity>>> getAllStaff(int page) async {
    try {
      var response = await dio.get(
        ApiEndpoints.allstaff,
        queryParameters: {
          'page': page,
          '_limit': ApiEndpoints.limitPage,
        },
      );

      print("API Response Data: ${response.data}");

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
      print("DioException: $e");
      print("Error Response: ${e.response}");
      return Left(Failure(error: e.response?.data['message']));
    }
  }
}
