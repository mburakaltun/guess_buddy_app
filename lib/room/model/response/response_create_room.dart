class ResponseCreateRoom {
  final int roomId;
  final String roomTitle;
  final String passcode;

  ResponseCreateRoom({
    required this.roomId,
    required this.roomTitle,
    required this.passcode,
  });

  factory ResponseCreateRoom.fromJson(Map<String, dynamic> json) {
    return ResponseCreateRoom(
      roomId: json['roomId'] as int,
      roomTitle: json['roomTitle'] as String,
      passcode: json['passcode'] as String,
    );
  }
}