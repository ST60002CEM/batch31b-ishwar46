class ProfileEntity {
  final String? userId;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String address;
  final String phone;
  final bool isAdmin;
  String? image;

  ProfileEntity({
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

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'address': address,
      'phone': phone,
      'isAdmin': isAdmin,
      'image': image,
    };
  }

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
        image,
      ];
}
