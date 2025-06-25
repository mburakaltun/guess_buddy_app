import 'package:guess_buddy_app/user/model/endpoint/user_endpoints.dart';

import '../../common/service/api_service.dart';
import '../model/request/request_change_password.dart';
import '../model/request/request_change_username.dart';
import '../model/request/request_get_user_profile.dart';
import '../model/response/response_change_password.dart';
import '../model/response/response_change_username.dart';
import '../model/response/response_get_user_profile.dart';

class UserService {
  final ApiService _apiService;

  UserService() : _apiService = ApiService();

  Future<ResponseGetUserProfile> getUserProfile(RequestGetUserProfile request) async {
    final response = await _apiService.get(endpoint: UserEndpoints.getUserProfile, params: request.toJson());
    return ResponseGetUserProfile.fromJson(response!);
  }

  Future<ResponseChangeUsername> changeUsername(RequestChangeUsername request) async {
    final responseData = await _apiService.put(endpoint: UserEndpoints.changeUsername, body: request.toJson());
    return ResponseChangeUsername.fromJson(responseData!);
  }

  Future<ResponseChangePassword> changePassword(RequestChangePassword request) async {
    final responseData = await _apiService.put(endpoint: UserEndpoints.changePassword, body: request.toJson());
    return ResponseChangePassword.fromJson(responseData!);
  }
}
