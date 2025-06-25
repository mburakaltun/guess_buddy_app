class RequestSubmitFeedback {
  final String content;
  final String? category;

  RequestSubmitFeedback({
    required this.content,
    this.category,
  });

  Map<String, dynamic> toJson() => {
    'content': content,
    if (category != null) 'category': category,
  };

  factory RequestSubmitFeedback.fromJson(Map<String, dynamic> json) {
    return RequestSubmitFeedback(
      content: json['content'],
      category: json['category'],
    );
  }
}