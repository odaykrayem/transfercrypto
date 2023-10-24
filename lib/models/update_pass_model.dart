// ignore_for_file: public_member_api_docs, sort_constructors_first
class UpdatePassBody {
  String email;
  String password;

  UpdatePassBody({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  @override
  String toString() {
    return 'UpdatePassBody(email: $email, password: $password)';
  }
}
