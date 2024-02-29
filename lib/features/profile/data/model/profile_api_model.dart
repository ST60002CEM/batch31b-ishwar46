import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/profile_entity.dart';

part 'profile_api_model.g.dart';

@JsonSerializable()
class ProfileApiModel {
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

  ProfileApiModel({
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

  factory ProfileApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileApiModelToJson(this);

  //to entity
  ProfileEntity toEntity() {
    return ProfileEntity(
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
  factory ProfileApiModel.fromEntity(ProfileEntity entity) {
    return ProfileApiModel(
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
