// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_staff_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllStaffDTO _$GetAllStaffDTOFromJson(Map<String, dynamic> json) =>
    GetAllStaffDTO(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: (json['users'] as List<dynamic>)
          .map((e) => StaffAPIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllStaffDTOToJson(GetAllStaffDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'users': instance.data,
    };
