class PredictionDTO {
  final int id;
  final String createdDate;
  final String? updatedDate;
  final int creatorUserId;
  final String title;
  final String description;
  final double averageScore;
  final int voteCount;
  final int userScore;
  final String creatorUsername;

  PredictionDTO({
    required this.id,
    required this.createdDate,
    this.updatedDate,
    required this.creatorUserId,
    required this.title,
    required this.description,
    required this.averageScore,
    required this.voteCount,
    required this.userScore,
    required this.creatorUsername,
  });

  factory PredictionDTO.fromJson(Map<String, dynamic> json) {
    return PredictionDTO(
      id: json['id'],
      createdDate: json['createdDate'],
      updatedDate: json['updatedDate'],
      creatorUserId: json['creatorUserId'],
      title: json['title'],
      description: json['description'],
      averageScore: json['averageScore'],
      voteCount: json['voteCount'] ?? 0,
      userScore: json['userScore'] ?? 0,
      creatorUsername: json['creatorUsername'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdDate': createdDate,
      'updatedDate': updatedDate,
      'creatorUserId': creatorUserId,
      'title': title,
      'description': description,
      'averageScore': averageScore,
      'voteCount': voteCount,
      'userScore': userScore,
      'creatorUsername': creatorUsername,
    };
  }
}