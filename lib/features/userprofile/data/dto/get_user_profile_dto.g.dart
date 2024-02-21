// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserProfileDTO _$GetUserProfileDTOFromJson(Map<String, dynamic> json) =>
    GetUserProfileDTO(
      success: json['success'] as bool,
      data: (json['userProfile'] as List<dynamic>)
          .map((e) => UserProfileAPIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String,
    );

Map<String, dynamic> _$GetUserProfileDTOToJson(GetUserProfileDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'userProfile': instance.data,
      'message': instance.message,
    };
