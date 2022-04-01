class RegisterBody {
  final String _email = "email";
  final String _password = "password";
  final String _role = "role";

  String email;
  String password;

  RegisterBody({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {_email: email, _password: password, _role: "User"};
  }
}
