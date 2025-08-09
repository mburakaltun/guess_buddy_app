class RequestFlagPrediction {
  final String predictionId;
  final String reason;

  RequestFlagPrediction({
    required this.predictionId,
    required this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'predictionId': predictionId,
      'reason': reason,
    };
  }

  factory RequestFlagPrediction.fromJson(Map<String, dynamic> json) {
    return RequestFlagPrediction(
      predictionId: json['predictionId'],
      reason: json['reason'],
    );
  }
}