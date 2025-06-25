class ResponseChangeUsername {
  final int id;
  final String username;

  ResponseChangeUsername({
    required this.id,
    required this.username,
  });

  factory ResponseChangeUsername.fromJson(Map<String, dynamic> json) {
    return ResponseChangeUsername(
      id: json['id'],
      username: json['username'],
    );
  }
}