class ResponseCompleteForgotPassword {
  final String userId;

  ResponseCompleteForgotPassword({required this.userId});

  factory ResponseCompleteForgotPassword.fromJson(Map<String, dynamic> json) {
    return ResponseCompleteForgotPassword(
        userId: json['userId'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId};
  }
}
