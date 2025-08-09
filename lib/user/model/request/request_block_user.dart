class RequestBlockUser {
  final int blockedUserId;

  RequestBlockUser({required this.blockedUserId});

  Map<String, dynamic> toJson() {
    return {
      'blockedUserId': blockedUserId,
    };
  }

  factory RequestBlockUser.fromJson(Map<String, dynamic> json) {
    return RequestBlockUser(
      blockedUserId: json['blockedUserId'],
    );
  }
}