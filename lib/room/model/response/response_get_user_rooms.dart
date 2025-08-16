import 'package:guess_buddy_app/common/model/response/pageable_response.dart';
import '../dto/user_room_dto.dart';

class ResponseGetUserRooms extends PageableResponse {
  final List<UserRoomDto> userRooms;

  ResponseGetUserRooms({
    super.number,
    super.totalElements,
    super.totalPages,
    super.isLast,
    required this.userRooms,
  });

  factory ResponseGetUserRooms.fromJson(Map<String, dynamic> json) {
    final pageableResponse = PageableResponse.fromJson(json);

    return ResponseGetUserRooms(
      number: pageableResponse.number,
      totalElements: pageableResponse.totalElements,
      totalPages: pageableResponse.totalPages,
      isLast: pageableResponse.isLast,
      userRooms: (json['userRooms'] as List)
          .map((itemJson) => UserRoomDto.fromJson(itemJson as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = super.toJson();
    json['userRooms'] = userRooms.map((item) => item.toJson()).toList();
    return json;
  }
}