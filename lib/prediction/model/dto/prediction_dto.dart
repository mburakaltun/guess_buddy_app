class PredictionDTO {
  final int predictionId;
  final String createdDate;
  final String? updatedDate;
  final int creatorUserId;
  final String title;
  final String description;
  final double averageScore;
  final int voteCount;

  PredictionDTO({
    required this.predictionId,
    required this.createdDate,
    this.updatedDate,
    required this.creatorUserId,
    required this.title,
    required this.description,
    required this.averageScore,
    required this.voteCount,
  });

  factory PredictionDTO.fromJson(Map<String, dynamic> json) {
    return PredictionDTO(
      predictionId: json['predictionId'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      creatorUserId: json['creatorUserId'],
      title: json['title'],
      description: json['description'],
      averageScore: json['averageScore'],
      voteCount: json['voteCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'predictionId': predictionId,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'creatorUserId': creatorUserId,
      'title': title,
      'description': description,
      'averageScore': averageScore,
      'voteCount': voteCount,
    };
  }
}