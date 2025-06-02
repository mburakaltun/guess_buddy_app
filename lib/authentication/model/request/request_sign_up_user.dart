class RequestSignUpUser {
  final String email;
  final String username;
  final String password;
  final String confirmPassword;

  RequestSignUpUser({
    required this.email,
    required this.username,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'username': username,
    'password': password,
    'confirmPassword': confirmPassword,
  };
}
