class ResponseStartForgotPassword {
  final bool emailSent;

  ResponseStartForgotPassword({this.emailSent = false});

  factory ResponseStartForgotPassword.fromJson(Map<String, dynamic> json) {
    return ResponseStartForgotPassword(
      emailSent: json['emailSent'] ?? false,
    );
  }
}
