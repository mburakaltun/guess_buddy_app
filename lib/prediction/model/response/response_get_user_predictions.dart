import 'package:guess_buddy_app/common/model/response/pageable_response.dart';
import '../dto/prediction_dto.dart';

class ResponseGetUserPredictions extends PageableResponse {
  final List<PredictionDto> predictionDtoList;

  ResponseGetUserPredictions({
    super.number,
    super.totalElements,
    super.totalPages,
    super.isLast,
    required this.predictionDtoList,
  });

  factory ResponseGetUserPredictions.fromJson(Map<String, dynamic> json) {
    final pageableResponse = PageableResponse.fromJson(json);

    return ResponseGetUserPredictions(
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