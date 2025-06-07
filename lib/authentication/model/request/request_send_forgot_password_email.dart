class RequestStartForgotPassword {
  final String email;

  RequestStartForgotPassword({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}