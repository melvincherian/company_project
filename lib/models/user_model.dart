class LoginResponse {
  final String message;
  final String token;
  final User user;

  LoginResponse({
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'user': user.toJson(),
    };
  }
}

class User {
  final String id;
  final String mobile;
  final String name;

  User({
    required this.id,
    required this.mobile,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      mobile: json['mobile'],
      name: json['name']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'mobile': mobile,
      'name': name,
    };
  }
}
