import 'package:equatable/equatable.dart';

class StaffEntity extends Equatable {
  final String staffId;
  final String firstName;
  final String lastName;
  final String email;
  final String? image;
  final String phone;
  final String username;
  final String address;

  const StaffEntity({
    required this.staffId,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.image,
    required this.phone,
    required this.username,
    required this.address,
  });

  @override
  List<Object?> get props => [
        staffId,
        firstName,
        lastName,
        email,
        image,
        phone,
        username,
        address,
      ];

  factory StaffEntity.fromJson(Map<String, dynamic> json) {
    return StaffEntity(
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
}
