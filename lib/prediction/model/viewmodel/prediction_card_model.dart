import '../dto/prediction_dto.dart';

class PredictionCardModel {
  final int id;
  final String title;
  final String description;
  final int voteCount;
  final double averageScore;
  final String createdDate;
  final int creatorUserId;

  PredictionCardModel({
    required this.id,
    required this.title,
    required this.description,
    required this.voteCount,
    required this.averageScore,
    required this.createdDate,
    required this.creatorUserId,
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
    );
  }
}
