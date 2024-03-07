class UserModel {
  final String id;
  final String email;
  final String userType;

  UserModel({required this.id, required this.email, required this.userType});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'userType': userType,
    };
  }
}
