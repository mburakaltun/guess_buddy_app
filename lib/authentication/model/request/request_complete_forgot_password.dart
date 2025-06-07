class RequestCompleteForgotPassword {
  final String token;
  final String newPassword;

  RequestCompleteForgotPassword({
    required this.token,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'newPassword': newPassword,
    };
  }
}