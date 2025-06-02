import '../dto/prediction_dto.dart';

class PredictionCardModel {
  final String title;
  final String description;
  final int voteCount;
  final double averageScore;
  final String createdDate;

  PredictionCardModel({
    required this.title,
    required this.description,
    required this.voteCount,
    required this.averageScore,
    required this.createdDate,
  });

  factory PredictionCardModel.fromDto(PredictionDTO dto) {
    return PredictionCardModel(
      title: dto.title,
      description: dto.description,
      voteCount: dto.voteCount,
      averageScore: dto.averageScore,
        createdDate: dto.createdDate
    );
  }
}