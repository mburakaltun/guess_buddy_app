class ResponseGetUserProfile {
  final String username;
  final String email;

  ResponseGetUserProfile({
    required this.username,
    required this.email,
  });

  factory ResponseGetUserProfile.fromJson(Map<String, dynamic> json) {
    return ResponseGetUserProfile(
      username: json['username'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
    };
  }
}
