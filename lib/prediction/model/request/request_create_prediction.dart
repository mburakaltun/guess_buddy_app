class RequestCreatePrediction {
  final String title;
  final String description;

  RequestCreatePrediction({
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
