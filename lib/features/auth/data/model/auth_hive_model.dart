import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/constants/hive_table.dart';
import '../../domain/entity/auth_entity.dart';

part 'auth_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.staffTableId)
class AuthHiveModel {
  @HiveField(0)
  final String staffId;

  @HiveField(1)
  final String firstName;

  @HiveField(2)
  final String lastName;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String phone;

  @HiveField(5)
  final String username;

  @HiveField(6)
  final String password;

  @HiveField(7)
  final String address;

  // Constructor
  AuthHiveModel({
    String? staffId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.address,
  }) : staffId = staffId ?? const Uuid().v4();

  // // empty constructor
  AuthHiveModel.empty()
      : this(
          staffId: '',
          firstName: '',
          lastName: '',
          email: '',
          phone: '',
          username: '',
          password: '',
          address: '',
        );

  // Convert Entity to Hive Object
  factory AuthHiveModel.toHiveModel(AuthEntity entity) => AuthHiveModel(
        firstName: entity.firstName,
        lastName: entity.lastName,
        email: entity.email,
        phone: entity.phone,
        username: entity.username,
        password: entity.password,
        address: entity.address,
      );

  // Convert Hive Object to Entity
  static AuthEntity toEntity(AuthHiveModel hiveModel) => AuthEntity(
        staffId: hiveModel.staffId,
        firstName: hiveModel.firstName,
        lastName: hiveModel.lastName,
        email: hiveModel.email,
        phone: hiveModel.phone,
        username: hiveModel.username,
        password: hiveModel.password,
        address: hiveModel.address,
      );

  @override
  String toString() {
    return 'staffId: $staffId, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone,username: $username, password: $password, address: $address';
  }

  @override
  List<Object?> get props =>
      [staffId, firstName, lastName, email, phone, username, password, address];
}
