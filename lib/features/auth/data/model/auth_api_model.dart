import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? staffId;
  final String fullName;
  final String email;
  final String? phone;
  final String username;
  final String password;
  final String? address;

  AuthApiModel({
    this.staffId,
    required this.fullName,
    required this.email,
    this.phone,
    required this.username,
    required this.password,
    this.address,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To entity
  factory AuthApiModel.toEntity(AuthApiModel apiModel) {
    return AuthApiModel(
      staffId: apiModel.staffId,
      fullName: apiModel.fullName,
      email: apiModel.email,
      phone: apiModel.phone,
      username: apiModel.username,
      password: apiModel.password,
      address: apiModel.address,
    );
  }

  // From entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      staffId: entity.staffId,
      fullName: entity.fullName,
      email: entity.email,
      phone: entity.phone,
      username: entity.username,
      password: entity.password,
      address: entity.address,
    );
  }
}
