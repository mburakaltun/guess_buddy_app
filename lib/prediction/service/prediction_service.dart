import 'package:guess_buddy_app/prediction/model/endpoint/prediction_endpoints.dart';
import 'package:guess_buddy_app/prediction/model/request/request_get_user_prediction_rates.dart';
import 'package:guess_buddy_app/prediction/model/response/response_create_prediction.dart';
import 'package:guess_buddy_app/prediction/model/response/response_get_user_prediction_rates.dart';
import '../../common/service/api_service.dart';
import '../model/request/request_create_prediction.dart';
import '../model/request/request_get_predictions.dart';
import '../model/response/response_get_predictions.dart';

class PredictionService {
  final ApiService _apiService;

  PredictionService() : _apiService = ApiService();

  Future<ResponseCreatePrediction> createPrediction({required RequestCreatePrediction requestCreatePrediction}) async {
    final response = await _apiService.post(
      endpoint: PredictionEndpoints.create,
      body: requestCreatePrediction.toJson(),
    );
    return ResponseCreatePrediction.fromJson(response!);
  }

  Future<ResponseGetPredictions> getPredictions({required RequestGetPredictions requestGetPredictions}) async {
    final response = await _apiService.get(
      endpoint: PredictionEndpoints.getPredictions,
      params: requestGetPredictions.toJson(),
    );
    return ResponseGetPredictions.fromJson(response!);
  }

  Future<ResponseGetUserPredictionRates> getUserPredictionRates({required RequestGetUserPredictionRates requestGetUserPredictionRates}) async {
    final response = await _apiService.get(
      endpoint: PredictionEndpoints.getUserPredictionRates,
      params: requestGetUserPredictionRates.toJson(),
    );
    return ResponseGetUserPredictionRates.fromJson(response!);
  }
}