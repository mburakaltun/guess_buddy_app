class ResponseChangePassword {
  final int userId;

  ResponseChangePassword({
    required this.userId,
  });

  factory ResponseChangePassword.fromJson(Map<String, dynamic> json) {
    return ResponseChangePassword(
      userId: json['userId'],
    );
  }
}