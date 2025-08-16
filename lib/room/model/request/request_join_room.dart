class RequestJoinRoom {
  final String passcode;

  RequestJoinRoom({
    required this.passcode,
  });

  Map<String, dynamic> toJson() {
    return {
      'passcode': passcode,
    };
  }
}