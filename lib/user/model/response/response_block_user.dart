class ResponseBlockUser {
  final int blockedUserId;

  ResponseBlockUser({required this.blockedUserId});

  factory ResponseBlockUser.fromJson(Map<String, dynamic> json) {
    return ResponseBlockUser(
      blockedUserId: json['blockedUserId'] ?? ''
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'blockedUserId': blockedUserId,
    };
  }
}