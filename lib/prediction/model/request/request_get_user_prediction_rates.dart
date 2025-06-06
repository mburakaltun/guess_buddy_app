import '../../../common/model/request/pageable_request.dart';

class RequestGetUserPredictionRates extends PageableRequest {
  RequestGetUserPredictionRates({
    required super.page,
    required super.size,
  });

  factory RequestGetUserPredictionRates.fromJson(Map<String, dynamic> json) {
    return RequestGetUserPredictionRates(
      page: json['page'],
      size: json['size'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'size': size,
    };
  }
}
