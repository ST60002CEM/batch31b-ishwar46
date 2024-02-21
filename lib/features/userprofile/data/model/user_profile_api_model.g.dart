// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileAPIModel _$UserProfileAPIModelFromJson(Map<String, dynamic> json) =>
    UserProfileAPIModel(
      userId: json['_id'] as String?,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      isAdmin: json['isAdmin'] as bool,
    );

Map<String, dynamic> _$UserProfileAPIModelToJson(
        UserProfileAPIModel instance) =>
    <String, dynamic>{
      '_id': instance.userId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'username': instance.username,
      'address': instance.address,
      'phone': instance.phone,
      'isAdmin': instance.isAdmin,
    };
