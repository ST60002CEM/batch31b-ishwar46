import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/staff_entity.dart';

part 'staff_api_model.g.dart';

@JsonSerializable()
class StaffAPIModel {
  @JsonKey(name: '_id')
  final String staffId;
  final String firstName;
  final String lastName;
  final String email;
  final String? image;
  final String? phone;
  final String? username;
  final String address;

  StaffAPIModel({
    required this.staffId,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.image,
    this.phone,
    this.username,
    required this.address,
  });

  factory StaffAPIModel.fromJson(Map<String, dynamic> json) {
    return StaffAPIModel(
      staffId: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'],
      phone: json['phone'],
      username: json['username'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': staffId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'image': image,
      'phone': phone,
      'username': username,
      'address': address,
    };
  }

  // From entity to model
  factory StaffAPIModel.fromEntity(StaffEntity entity) {
    return StaffAPIModel(
      staffId: entity.staffId,
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      image: entity.image,
      phone: entity.phone,
      username: entity.username,
      address: entity.address,
    );
  }

  // From model to entity
  static StaffEntity toEntity(StaffAPIModel model) {
    return StaffEntity(
      staffId: model.staffId,
      firstName: model.firstName,
      lastName: model.lastName,
      email: model.email,
      image: model.image,
      phone: model.phone,
      username: model.username,
      address: model.address,
    );
  }
}
