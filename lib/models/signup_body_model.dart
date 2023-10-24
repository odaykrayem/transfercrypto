// ignore_for_file: public_member_api_docs, sort_constructors_first
class SignUpBody {
  String firstName;
  String lastName;
  String email;
  String password;

  SignUpBody({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = firstName;
    data['l_name'] = lastName;
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  @override
  String toString() {
    return 'SignUpBody(name: $firstName, lastName: $lastName, email: $email, password: $password)';
  }
}
