// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OTPApiModel _$OTPApiModelFromJson(Map<String, dynamic> json) => OTPApiModel(
      otpId: json['_id'] as String?,
      userId: json['userId'] as String?,
      otp: json['otp'] as String?,
      createdAt: json['createdAt'] as String?,
      expiryTime: json['expiryTime'] as String?,
    );

Map<String, dynamic> _$OTPApiModelToJson(OTPApiModel instance) =>
    <String, dynamic>{
      '_id': instance.otpId,
      'userId': instance.userId,
      'otp': instance.otp,
      'createdAt': instance.createdAt,
      'expiryTime': instance.expiryTime,
    };
