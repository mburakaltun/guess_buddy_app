class UserRoomDto {
  final bool isHost;
  final int roomId;
  final String passcode;
  final String roomTitle;

  UserRoomDto({
    required this.isHost,
    required this.roomId,
    required this.passcode,
    required this.roomTitle,
  });

  factory UserRoomDto.fromJson(Map<String, dynamic> json) {
    return UserRoomDto(
      isHost: json['isHost'] as bool,
      roomId: json['roomId'] as int,
      passcode: json['passcode'] as String,
      roomTitle: json['roomTitle'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isHost': isHost,
      'roomId': roomId,
      'passcode': passcode,
      'roomTitle': roomTitle,
    };
  }
}