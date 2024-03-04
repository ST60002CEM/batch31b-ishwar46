import 'package:age_care/features/profile/domain/entity/profile_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'profile_hive_model.g.dart';

final profileHiveModelProvider = Provider((ref) => ProfileHiveModel.empty());

@HiveType(typeId: 1)
class ProfileHiveModel {
  @HiveField(0)
  final String userId;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String username;
  @HiveField(5)
  final String address;
  @HiveField(6)
  final String phone;
  @HiveField(7)
  final bool isAdmin;

  //emnpty constructor
  ProfileHiveModel.empty()
      : this(
          userId: '',
          firstName: '',
          lastName: '',
          email: '',
          username: '',
          address: '',
          phone: '',
          isAdmin: false,
        );

  ProfileHiveModel({
    String? userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.address,
    required this.phone,
    required this.isAdmin,
  }) : userId = userId ?? const Uuid().v4();

  //Convert Hive Object to
  ProfileEntity toEntity() => ProfileEntity(
        userId: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        username: username,
        address: address,
        phone: phone,
        isAdmin: isAdmin,
      );

  //Entity to hive object
  ProfileHiveModel fromEntity(ProfileEntity entity) => ProfileHiveModel(
        userId: entity.userId ?? const Uuid().v4(),
        firstName: entity.firstName,
        lastName: entity.lastName,
        email: entity.email,
        username: entity.username,
        address: entity.address,
        phone: entity.phone,
        isAdmin: entity.isAdmin,
      );

  //Convert Entity List to Hive  Object
  ProfileHiveModel toHiveModel(ProfileEntity entity) => ProfileHiveModel(
        userId: entity.userId ?? const Uuid().v4(),
        firstName: entity.firstName,
        lastName: entity.lastName,
        email: entity.email,
        username: entity.username,
        address: entity.address,
        phone: entity.phone,
        isAdmin: entity.isAdmin,
      );

  //Convert Hive List to Entity List
  List<ProfileEntity> toEntityList(List<ProfileHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'ProfileHiveModel(userId: $userId, firstName: $firstName, lastName: $lastName, email: $email, username: $username, address: $address, phone: $phone, isAdmin: $isAdmin)';
  }
}
