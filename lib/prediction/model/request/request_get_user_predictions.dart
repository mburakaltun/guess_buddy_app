import 'package:guess_buddy_app/common/model/request/pageable_request.dart';

class RequestGetUserPredictions extends PageableRequest {
  RequestGetUserPredictions({
    required super.page,
    required super.size,
  });

  factory RequestGetUserPredictions.fromJson(Map<String, dynamic> json) {
    return RequestGetUserPredictions(
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
