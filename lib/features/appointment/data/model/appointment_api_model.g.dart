// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentApiModel _$AppointmentApiModelFromJson(Map<String, dynamic> json) =>
    AppointmentApiModel(
      serviceType: json['serviceType'] as String,
      serviceDate: json['serviceDate'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      location: json['location'] as String,
      notes: json['notes'] as String,
    );

Map<String, dynamic> _$AppointmentApiModelToJson(
        AppointmentApiModel instance) =>
    <String, dynamic>{
      'serviceType': instance.serviceType,
      'serviceDate': instance.serviceDate,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'location': instance.location,
      'notes': instance.notes,
    };
