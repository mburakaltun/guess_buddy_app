import 'package:guess_buddy_app/vote/model/endpoint/vote_endpoints.dart';
import 'package:guess_buddy_app/vote/model/request/request_vote_prediction.dart';
import 'package:guess_buddy_app/vote/model/response/response_vote_prediction.dart';

import '../../common/service/api_service.dart';

class VoteService {
  final ApiService _apiService;

  VoteService() : _apiService = ApiService();

  Future<ResponseVotePrediction> votePrediction({required RequestVotePrediction requestVotePrediction}) async {
    final response = await _apiService.post(
      endpoint: VoteEndpoints.votePrediction,
      body: requestVotePrediction.toJson(),
    );
    return ResponseVotePrediction.fromJson(response!);
  }
}