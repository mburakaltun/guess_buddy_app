class ResponseLeaveRoom {
  final bool? isAlreadyLeft;
  final int roomId;

  ResponseLeaveRoom({
    this.isAlreadyLeft,
    required this.roomId,
  });

  factory ResponseLeaveRoom.fromJson(Map<String, dynamic> json) {
    return ResponseLeaveRoom(
      isAlreadyLeft: json['isAlreadyLeft'] as bool?,
      roomId: json['roomId'] as int,
    );
  }
}