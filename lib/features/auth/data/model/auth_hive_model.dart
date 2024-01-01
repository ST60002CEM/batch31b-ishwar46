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
  final String fullName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String username;

  @HiveField(5)
  final String password;

  @HiveField(6)
  final String address;

  // Constructor
  AuthHiveModel({
    String? staffId,
    required this.fullName,
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
          fullName: '',
          email: '',
          phone: '',
          username: '',
          password: '',
          address: '',
        );

  // Convert Entity to Hive Object
  factory AuthHiveModel.toHiveModel(AuthEntity entity) => AuthHiveModel(
        fullName: entity.fullName,
        email: entity.email,
        phone: entity.phone,
        username: entity.username,
        password: entity.password,
        address: entity.address,
      );

  // Convert Hive Object to Entity
  static AuthEntity toEntity(AuthHiveModel hiveModel) => AuthEntity(
        staffId: hiveModel.staffId,
        fullName: hiveModel.fullName,
        email: hiveModel.email,
        phone: hiveModel.phone,
        username: hiveModel.username,
        password: hiveModel.password,
        address: hiveModel.address,
      );

  @override
  String toString() {
    return 'staffId: $staffId, fullName: $fullName, lname: $email, phone: $phone,username: $username, password: $password, address: $address';
  }
}
