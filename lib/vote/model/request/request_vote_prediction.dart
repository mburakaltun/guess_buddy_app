class RequestVotePrediction {
  final int predictionId;
  final int score;

  RequestVotePrediction({
    required this.predictionId,
    required this.score,
  });

  Map<String, dynamic> toJson() {
    return {
      'predictionId': predictionId,
      'score': score,
    };
  }

  factory RequestVotePrediction.fromJson(Map<String, dynamic> json) {
    return RequestVotePrediction(
      predictionId: json['predictionId'],
      score: json['score'],
    );
  }
}
