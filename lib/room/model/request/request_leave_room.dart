class RequestLeaveRoom {
  final int roomId;

  RequestLeaveRoom({
    required this.roomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}