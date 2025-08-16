class RequestCloseRoom {
  final int roomId;

  RequestCloseRoom({
    required this.roomId,
  });

  Map<String, dynamic> toJson() {
    return {
      'roomId': roomId,
    };
  }
}