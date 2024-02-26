// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppointmentApiModel _$AppointmentApiModelFromJson(Map<String, dynamic> json) =>
    AppointmentApiModel(
      appointmentId: json['_id'] as String?,
      serviceType: json['serviceType'] as String,
      serviceDate: json['serviceDate'] as String,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      location: json['location'] as String,
      notes: json['notes'] as String,
      ticketNumber: json['ticketNumber'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AppointmentApiModelToJson(
        AppointmentApiModel instance) =>
    <String, dynamic>{
      '_id': instance.appointmentId,
      'serviceType': instance.serviceType,
      'serviceDate': instance.serviceDate,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'location': instance.location,
      'notes': instance.notes,
      'ticketNumber': instance.ticketNumber,
      'status': instance.status,
    };
