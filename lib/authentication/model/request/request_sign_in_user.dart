class RequestSignInUser {
  final String email;
  final String password;

  RequestSignInUser({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}
