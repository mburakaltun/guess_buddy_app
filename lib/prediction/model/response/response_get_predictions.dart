import 'package:guess_buddy_app/common/model/response/pageable_response.dart';
import '../dto/prediction_dto.dart';

class ResponseGetPredictions extends PageableResponse {
  final List<PredictionDTO> predictionDTOList;

  ResponseGetPredictions({
    super.number,
    super.totalElements,
    super.totalPages,
    super.isLast,
    required this.predictionDTOList,
  });

  factory ResponseGetPredictions.fromJson(Map<String, dynamic> json) {
    final pageableResponse = PageableResponse.fromJson(json);

    return ResponseGetPredictions(
      number: pageableResponse.number,
      totalElements: pageableResponse.totalElements,
      totalPages: pageableResponse.totalPages,
      isLast: pageableResponse.isLast,
      predictionDTOList: (json['predictionDTOList'] as List)
          .map((itemJson) => PredictionDTO.fromJson(itemJson as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = super.toJson();
    json['predictionDTOList'] = predictionDTOList.map((item) => item.toJson()).toList();
    return json;
  }
}