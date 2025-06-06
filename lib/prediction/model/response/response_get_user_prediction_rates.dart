import '../../../common/model/response/pageable_response.dart';
import '../dto/user_prediction_hit_rate_dto.dart';

class ResponseGetUserPredictionRates extends PageableResponse {
  final List<UserPredictionHitRateDto> userPredictionHitRateDtoList;

  ResponseGetUserPredictionRates({
    required super.number,
    required super.totalElements,
    required super.totalPages,
    required super.isLast,
    required this.userPredictionHitRateDtoList,
  });

  factory ResponseGetUserPredictionRates.fromJson(Map<String, dynamic> json) {
    return ResponseGetUserPredictionRates(
      number: json['number'],
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
      isLast: json['isLast'],
      userPredictionHitRateDtoList: (json['userPredictionHitRateDtoList'] as List)
          .map((e) => UserPredictionHitRateDto.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'totalElements': totalElements,
      'totalPages': totalPages,
      'isLast': isLast,
      'userPredictionHitRateDtoList':
      userPredictionHitRateDtoList.map((e) => e.toJson()).toList(),
    };
  }
}
