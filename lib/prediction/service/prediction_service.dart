import 'package:guess_buddy_app/prediction/model/endpoint/prediction_endpoints.dart';
import 'package:guess_buddy_app/prediction/model/request/request_get_user_prediction_rates.dart';
import 'package:guess_buddy_app/prediction/model/request/request_get_user_predictions.dart';
import 'package:guess_buddy_app/prediction/model/response/response_create_prediction.dart';
import 'package:guess_buddy_app/prediction/model/response/response_get_user_prediction_rates.dart';
import 'package:guess_buddy_app/prediction/model/response/response_get_user_predictions.dart';
import '../../common/service/api_service.dart';
import '../model/request/request_create_prediction.dart';
import '../model/request/request_flag_prediction.dart';
import '../model/request/request_get_predictions.dart';
import '../model/response/response_flag_prediction.dart';
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

  Future<ResponseGetUserPredictions> getUserPredictions({required RequestGetUserPredictions requestGetUserPredictions}) async {
    final response = await _apiService.get(
      endpoint: PredictionEndpoints.getUserPredictions,
      params: requestGetUserPredictions.toJson(),
    );
    return ResponseGetUserPredictions.fromJson(response!);
  }

  Future<ResponseFlagPrediction> flagPrediction({required RequestFlagPrediction requestFlagPrediction}) async {
    final response = await _apiService.post(
      endpoint: PredictionEndpoints.flagPrediction,
      body: requestFlagPrediction.toJson(),
    );
    return ResponseFlagPrediction.fromJson(response!);
  }
}