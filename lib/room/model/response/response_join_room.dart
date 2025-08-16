class ResponseJoinRoom {
  final bool isHost;
  final int roomId;
  final String roomTitle;
  final String passcode;

  ResponseJoinRoom({
    required this.isHost,
    required this.roomId,
    required this.roomTitle,
    required this.passcode,
  });

  factory ResponseJoinRoom.fromJson(Map<String, dynamic> json) {
    return ResponseJoinRoom(
      isHost: json['isHost'] as bool,
      roomId: json['roomId'] as int,
      roomTitle: json['roomTitle'] as String,
      passcode: json['passcode'] as String,
    );
  }
}