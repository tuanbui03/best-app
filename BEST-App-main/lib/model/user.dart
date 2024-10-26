class Users {
  final int id;
  final String firstName;
  final String lastName;
  final String userName;
  final String password;
  final int gender;
  final String email;
  final String image;
  final String phone;
  final String address;
  final String birthday;
  final int role;
  final int status;

  Users(
      this.id,
      this.firstName,
      this.lastName,
      this.userName,
      this.password,
      this.gender,
      this.email,
      this.image,
      this.phone,
      this.address,
      this.birthday,
      this.role,
      this.status);

  static Map<String, dynamic> toJson(Users user) {
    return {
      'id': user.id,
      'first_name': user.firstName,
      'last_name': user.lastName,
      'user_name': user.userName,
      'password': user.password,
      'gender': user.gender,
      'email': user.email,
      'image': user.image,
      'phone': user.phone,
      'address': user.address,
      'birthday': user.birthday,
      'role': user.role,
      'status': user.status
    };
  }
}
