import 'package:guess_buddy_app/user/model/dto/user_dto.dart';

class ResponseGetBlockedUsers {
  final List<UserDto> blockedUserDtoList;

  ResponseGetBlockedUsers({required this.blockedUserDtoList});

  factory ResponseGetBlockedUsers.fromJson(Map<String, dynamic> json) {
    var list = json['blockedUserDtoList'] as List;
    List<UserDto> blockedUserDtoList = list.map((i) => UserDto.fromJson(i)).toList();

    return ResponseGetBlockedUsers(blockedUserDtoList: blockedUserDtoList);
  }

  Map<String, dynamic> toJson() {
    return {
      'blockedUserDtoList': blockedUserDtoList.map((user) => user.toJson()).toList(),
    };
  }
}