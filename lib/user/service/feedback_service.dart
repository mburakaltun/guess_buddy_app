import '../../common/service/api_service.dart';
import '../model/endpoint/feedback_endpoints.dart';
import '../model/request/request_submit_feedback.dart';
import '../model/response/response_submit_feedback.dart';

class FeedbackService {
  final ApiService _apiService;

  FeedbackService() : _apiService = ApiService();

  Future<ResponseSubmitFeedback> submitFeedback(RequestSubmitFeedback request) async {
    final responseData = await _apiService.post(endpoint: FeedbackEndpoints.submitFeedback, body: request.toJson(),);
    return ResponseSubmitFeedback.fromJson(responseData!);
  }
}