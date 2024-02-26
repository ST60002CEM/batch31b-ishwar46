// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_appointments_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAppointmentsDTO _$GetAppointmentsDTOFromJson(Map<String, dynamic> json) =>
    GetAppointmentsDTO(
      success: json['success'] as bool,
      data: (json['appointments'] as List<dynamic>)
          .map((e) => AppointmentApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAppointmentsDTOToJson(GetAppointmentsDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'appointments': instance.data,
    };
