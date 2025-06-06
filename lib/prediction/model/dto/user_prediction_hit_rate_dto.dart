class UserPredictionHitRateDto {
  final int userId;
  final String username;
  final int totalPredictionCount;
  final int successfulPredictionCount;
  final double successRate;

  UserPredictionHitRateDto({
    required this.userId,
    required this.username,
    required this.totalPredictionCount,
    required this.successfulPredictionCount,
    required this.successRate,
  });

  factory UserPredictionHitRateDto.fromJson(Map<String, dynamic> json) {
    return UserPredictionHitRateDto(
      userId: json['userId'],
      username: json['username'],
      totalPredictionCount: json['totalPredictionCount'],
      successfulPredictionCount: json['successfulPredictionCount'],
      successRate: (json['successRate'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'totalPredictionCount': totalPredictionCount,
      'successfulPredictionCount': successfulPredictionCount,
      'successRate': successRate,
    };
  }
}
