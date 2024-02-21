class UserEntity {
  final String? userId;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String address;
  final String phone;
  final bool isAdmin;

  UserEntity({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.address,
    required this.phone,
    required this.isAdmin,
  });

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        email,
        username,
        address,
        phone,
        isAdmin,
      ];

  // factory UserEntity.fromJson(Map<String, dynamic> json) {
  //   return UserEntity(
  //     userId: json['_id'],
  //     firstName: json['firstName'],
  //     lastName: json['lastName'],
  //     email: json['email'],
  //     username: json['username'],
  //     address: json['address'],
  //     phone: json['phone'],
  //     isAdmin: json['isAdmin'],
  //   );
  // }
}
