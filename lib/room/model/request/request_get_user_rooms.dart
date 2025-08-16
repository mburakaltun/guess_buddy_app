import 'package:guess_buddy_app/common/model/request/pageable_request.dart';

class RequestGetUserRooms extends PageableRequest {
  RequestGetUserRooms({
    required super.page,
    required super.size,
  });

  factory RequestGetUserRooms.fromJson(Map<String, dynamic> json) {
    return RequestGetUserRooms(
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