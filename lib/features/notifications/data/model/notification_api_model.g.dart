// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationApiModel _$NotificationApiModelFromJson(
        Map<String, dynamic> json) =>
    NotificationApiModel(
      notificationId: json['_id'] as String,
      recipient: json['recipient'] as String,
      message: json['message'] as String,
      read: json['read'] as bool,
      createdAt: json['createdAt'] as String?,
      createdAtFormatted: json['createdAtFormatted'] as String,
    );

Map<String, dynamic> _$NotificationApiModelToJson(
        NotificationApiModel instance) =>
    <String, dynamic>{
      '_id': instance.notificationId,
      'recipient': instance.recipient,
      'message': instance.message,
      'read': instance.read,
      'createdAt': instance.createdAt,
      'createdAtFormatted': instance.createdAtFormatted,
    };
