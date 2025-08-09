class ResponseUnblockUser {
  final int unblockedUserId;

  ResponseUnblockUser({required this.unblockedUserId});

  Map<String, dynamic> toJson() {
    return {
      'blockedUserId': unblockedUserId,
    };
  }

  factory ResponseUnblockUser.fromJson(Map<String, dynamic> json) {
    return ResponseUnblockUser(
      unblockedUserId: json['unblockedUserId'],
    );
  }
}