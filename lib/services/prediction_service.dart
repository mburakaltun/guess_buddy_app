import 'package:guess_buddy_app/endpoints/prediction_endpoints.dart';

import '../endpoints/authentication_endpoints.dart';
import 'api_service.dart';

class PredictionService {
  final ApiService _apiService;

  PredictionService() : _apiService = ApiService();

  Future<void> create({required String title, required String description}) async {
    await _apiService.post(endpoint: PredictionEndpoints.create, body: {'title': title, 'description': description});
  }
}
