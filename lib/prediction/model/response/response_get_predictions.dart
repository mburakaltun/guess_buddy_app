import 'package:guess_buddy_app/common/model/response/pageable_response.dart';
import '../dto/prediction_dto.dart';

class ResponseGetPredictions extends PageableResponse {
  final List<PredictionDto> predictionDtoList;

  ResponseGetPredictions({
    super.number,
    super.totalElements,
    super.totalPages,
    super.isLast,
    required this.predictionDtoList,
  });

  factory ResponseGetPredictions.fromJson(Map<String, dynamic> json) {
    final pageableResponse = PageableResponse.fromJson(json);

    return ResponseGetPredictions(
      number: pageableResponse.number,
      totalElements: pageableResponse.totalElements,
      totalPages: pageableResponse.totalPages,
      isLast: pageableResponse.isLast,
      predictionDtoList: (json['predictionDtoList'] as List)
          .map((itemJson) => PredictionDto.fromJson(itemJson as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = super.toJson();
    json['predictionDtoList'] = predictionDtoList.map((item) => item.toJson()).toList();
    return json;
  }
}