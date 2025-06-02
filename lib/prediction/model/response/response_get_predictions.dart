import '../dto/prediction_dto.dart';

class ResponseGetPredictions {
  final List<PredictionDTO> predictionDTOList;

  ResponseGetPredictions({
    required this.predictionDTOList,
  });

  factory ResponseGetPredictions.fromJson(Map<String, dynamic> json) {
    return ResponseGetPredictions(
      predictionDTOList: (json['predictionDTOList'] as List)
          .map((item) => PredictionDTO.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'predictionDTOList': predictionDTOList.map((item) => item.toJson()).toList(),
    };
  }
}