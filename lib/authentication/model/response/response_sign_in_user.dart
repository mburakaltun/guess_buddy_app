class ResponseSignInUser {
  final String authenticationToken;
  final String userId;
  final String username;

  ResponseSignInUser({
    required this.authenticationToken,
    required this.userId,
    required this.username,
  });

  factory ResponseSignInUser.fromJson(Map<String, dynamic> json) {
    return ResponseSignInUser(
      authenticationToken: json['authenticationToken'],
      userId: json['userId'],
      username: json['username'],
    );
  }
}
