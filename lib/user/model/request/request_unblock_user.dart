class RequestUnblockUser {
  final int unblockedUserId;

  RequestUnblockUser({required this.unblockedUserId});

  Map<String, dynamic> toJson() {
    return {
      'userId': unblockedUserId,
    };
  }

  factory RequestUnblockUser.fromJson(Map<String, dynamic> json) {
    return RequestUnblockUser(
      unblockedUserId: json['userId'],
    );
  }
}