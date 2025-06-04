class ResponseVotePrediction {
  final bool isVotedSuccessfully;

  ResponseVotePrediction({required this.isVotedSuccessfully});

  factory ResponseVotePrediction.fromJson(Map<String, dynamic> json) {
    return ResponseVotePrediction(
      isVotedSuccessfully: json['isVotedSuccessfully'],
    );
  }
}
