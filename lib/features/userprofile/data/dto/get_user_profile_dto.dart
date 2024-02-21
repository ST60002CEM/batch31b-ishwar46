import 'package:age_care/features/userprofile/data/model/user_profile_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_user_profile_dto.g.dart';

@JsonSerializable()
class GetUserProfileDTO {
  final bool success;
  final String message;
  @JsonKey(name: 'userProfile')
  final List<UserProfileAPIModel> data;

  GetUserProfileDTO({
    required this.success,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetUserProfileDTOToJson(this);

  factory GetUserProfileDTO.fromJson(Map<String, dynamic> json) =>
      _$GetUserProfileDTOFromJson(json);
}
