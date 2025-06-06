import '../dto/prediction_dto.dart';

class PredictionCardModel {
  final int id;
  final String title;
  final String description;
  final int voteCount;
  final double averageScore;
  final String createdDate;
  final int creatorUserId;
  final int userScore;
  final String creatorUsername;

  PredictionCardModel({
    required this.id,
    required this.title,
    required this.description,
    required this.voteCount,
    required this.averageScore,
    required this.createdDate,
    required this.creatorUserId,
    required this.userScore,
    required this.creatorUsername,
  });

  factory PredictionCardModel.fromDto(PredictionDTO dto) {
    return PredictionCardModel(
      id: dto.id,
      title: dto.title,
      description: dto.description,
      voteCount: dto.voteCount,
      averageScore: dto.averageScore,
      createdDate: dto.createdDate,
      creatorUserId: dto.creatorUserId,
      userScore: dto.userScore,
      creatorUsername: dto.creatorUsername,
    );
  }
}
