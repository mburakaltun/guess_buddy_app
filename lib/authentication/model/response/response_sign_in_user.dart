class ResponseSignInUser {
  final String authenticationToken;
  final String userId;

  ResponseSignInUser({
    required this.authenticationToken,
    required this.userId,
  });

  factory ResponseSignInUser.fromJson(Map<String, dynamic> json) {
    return ResponseSignInUser(
      authenticationToken: json['authenticationToken'],
      userId: json['userId'],
    );
  }
}
