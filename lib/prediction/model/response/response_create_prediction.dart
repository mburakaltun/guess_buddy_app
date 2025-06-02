class ResponseCreatePrediction {
  final int predictionId;

  ResponseCreatePrediction({
    required this.predictionId,
  });

  factory ResponseCreatePrediction.fromJson(Map<String, dynamic> json) {
    return ResponseCreatePrediction(
      predictionId: json['predictionId'] as int,
    );
  }
}
