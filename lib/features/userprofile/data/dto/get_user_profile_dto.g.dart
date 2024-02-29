// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserProfileDTO _$GetUserProfileDTOFromJson(Map<String, dynamic> json) =>
    GetUserProfileDTO(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['userProfile'] as List<dynamic>)
          .map((e) => UserProfileAPIModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetUserProfileDTOToJson(GetUserProfileDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'userProfile': instance.data,
    };
