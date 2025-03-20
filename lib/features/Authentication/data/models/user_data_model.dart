class UserDataModel {
  final String userId;
  final String name;
  final String email;

  UserDataModel({
    required this.userId,
    required this.name,
    required this.email,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
    };
  }
}
