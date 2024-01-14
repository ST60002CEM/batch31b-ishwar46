// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaffAPIModel _$StaffAPIModelFromJson(Map<String, dynamic> json) =>
    StaffAPIModel(
      staffId: json['_id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      image: json['image'] as String?,
      phone: json['phone'] as String?,
      username: json['username'] as String?,
      address: json['address'] as String,
    );

Map<String, dynamic> _$StaffAPIModelToJson(StaffAPIModel instance) =>
    <String, dynamic>{
      '_id': instance.staffId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'image': instance.image,
      'phone': instance.phone,
      'username': instance.username,
      'address': instance.address,
    };
