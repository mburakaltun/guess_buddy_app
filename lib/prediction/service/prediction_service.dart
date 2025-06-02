import 'package:guess_buddy_app/prediction/model/endpoint/prediction_endpoints.dart';
import 'package:guess_buddy_app/prediction/model/response/ResponseCreatePrediction.dart';
import '../../common/service/api_service.dart';
import '../model/request/RequestCreatePrediction.dart';

class PredictionService {
  final ApiService _apiService;

  PredictionService() : _apiService = ApiService();

  Future<ResponseCreatePrediction> create({required RequestCreatePrediction requestCreatePrediction}) async {
    final response = await _apiService.post(
      endpoint: PredictionEndpoints.create,
      body: requestCreatePrediction.toJson(),
    );
    return ResponseCreatePrediction.fromJson(response!);
  }
}