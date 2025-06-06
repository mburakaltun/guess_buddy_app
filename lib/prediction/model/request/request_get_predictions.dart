import 'package:guess_buddy_app/common/model/request/pageable_request.dart';

class RequestGetPredictions extends PageableRequest {
  RequestGetPredictions({
    required super.page,
    required super.size,
  });

  factory RequestGetPredictions.fromJson(Map<String, dynamic> json) {
    return RequestGetPredictions(
      page: json['page'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'size': size,
    };
  }
}
