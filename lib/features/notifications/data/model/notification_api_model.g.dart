// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationApiModel _$NotificationApiModelFromJson(
        Map<String, dynamic> json) =>
    NotificationApiModel(
      notificationId: json['id'] as String?,
      recipient: json['recipient'] as String?,
      message: json['message'] as String,
      date: json['date'] as String,
      read: json['read'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$NotificationApiModelToJson(
        NotificationApiModel instance) =>
    <String, dynamic>{
      'id': instance.notificationId,
      'recipient': instance.recipient,
      'message': instance.message,
      'date': instance.date,
      'read': instance.read,
      'createdAt': instance.createdAt,
    };
