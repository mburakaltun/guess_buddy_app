import 'dart:ffi';

class ResponseCreatePrediction {
  final Long predictionId;

  ResponseCreatePrediction({
    required this.predictionId,
  });

  factory ResponseCreatePrediction.fromJson(Map<String, dynamic> json) {
    return ResponseCreatePrediction(
      predictionId: json['predictionId'] as Long,
    );
  }
}
