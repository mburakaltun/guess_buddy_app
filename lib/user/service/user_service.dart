import 'package:guess_buddy_app/user/model/endpoint/user_endpoints.dart';

import '../../common/service/api_service.dart';
import '../model/request/request_get_user_profile.dart';
import '../model/response/response_get_user_profile.dart';

class UserService {
  final ApiService _apiService;

  UserService() : _apiService = ApiService();

  Future<ResponseGetUserProfile> getUserProfile(RequestGetUserProfile request) async {
    final response = await _apiService.get(
      endpoint: UserEndpoints.getUserProfile,
      params: request.toJson(),
    );
    return ResponseGetUserProfile.fromJson(response!);
  }
}
