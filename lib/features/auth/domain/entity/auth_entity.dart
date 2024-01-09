import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? staffId;
  final String firstName;
  final String lastName;
  final String email;
  final String? image;
  final String phone;
  final String username;
  final String password;
  final String address;

  const AuthEntity({
    this.staffId,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.image,
    required this.phone,
    required this.username,
    required this.password,
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
        password,
        address
      ];
}
