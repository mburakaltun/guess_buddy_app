class ResponseVotePrediction {
  final bool isVotedSuccessfully;
  final double averageScore;
  final int voteCount;

  ResponseVotePrediction({
    required this.isVotedSuccessfully,
    required this.averageScore,
    required this.voteCount,
  });

  factory ResponseVotePrediction.fromJson(Map<String, dynamic> json) {
    return ResponseVotePrediction(
      isVotedSuccessfully: json['isVotedSuccessfully'],
      averageScore: (json['averageScore'] as num).toDouble(),
      voteCount: json['voteCount'],
    );
  }
}
