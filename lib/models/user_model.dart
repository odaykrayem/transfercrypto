// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  int id;
  String firstName;
  String lastName;
  String email;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['f_name'],
      lastName: json['l_name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'f_name': firstName,
      'l_name': lastName,
      'email': email,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
