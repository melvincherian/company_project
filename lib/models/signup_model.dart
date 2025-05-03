class SignupModel {
  final String id; 
  final String name;
  final String email;
  final String mobile;
  final String dob;
  final String marriageAnniversary;

  SignupModel({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.dob,
    required this.marriageAnniversary,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      id: json['_id'] ?? '',
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      dob: json['dob'],
      marriageAnniversary: json['marriageAnniversary'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id, 
      'name': name,
      'email': email,
      'mobile': mobile,
      'dob': dob,
      'marriageAnniversary': marriageAnniversary,
    };
  }
}
