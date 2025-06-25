class ResponseSubmitFeedback {
  final int userId;

  ResponseSubmitFeedback({
    required this.userId,
  });

  factory ResponseSubmitFeedback.fromJson(Map<String, dynamic> json) {
    return ResponseSubmitFeedback(
      userId: json['userId'],
    );
  }
}