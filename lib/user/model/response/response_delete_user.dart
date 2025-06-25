class ResponseDeleteUser {
  final int userId;

  ResponseDeleteUser({
    required this.userId,
  });

  factory ResponseDeleteUser.fromJson(Map<String, dynamic> json) {
    return ResponseDeleteUser(
      userId: json['userId'],
    );
  }
}