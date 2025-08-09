class ResponseFlagPrediction {
  final int flagId;
  final int predictionId;
  final int reporterUserId;

  ResponseFlagPrediction({
    required this.flagId,
    required this.predictionId,
    required this.reporterUserId,
  });

  factory ResponseFlagPrediction.fromJson(Map<String, dynamic> json) {
    return ResponseFlagPrediction(
      flagId: json['flagId'] ?? 0,
      predictionId: json['predictionId'] ?? 0,
      reporterUserId: json['reporterUserId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'flagId': flagId,
      'predictionId': predictionId,
      'reporterUserId': reporterUserId,
    };
  }
}