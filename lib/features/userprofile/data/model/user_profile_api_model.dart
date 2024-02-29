import 'package:age_care/features/userprofile/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_api_model.g.dart';

@JsonSerializable()
class UserProfileAPIModel {
  @JsonKey(name: '_id')
  final String? userId;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String address;
  final String phone;
  final bool isAdmin;
  String? image;

  UserProfileAPIModel({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.address,
    required this.phone,
    required this.isAdmin,
    this.image,
  });

  factory UserProfileAPIModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileAPIModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileAPIModelToJson(this);

  //to entity
  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      username: username,
      address: address,
      phone: phone,
      isAdmin: isAdmin,
      image: image ?? '',
    );
  }

  //from entity
  factory UserProfileAPIModel.fromEntity(UserEntity entity) {
    return UserProfileAPIModel(
      userId: entity.userId,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      username: entity.username,
      address: entity.address,
      phone: entity.phone,
      isAdmin: entity.isAdmin,
      image: entity.image,
    );
  }
}
