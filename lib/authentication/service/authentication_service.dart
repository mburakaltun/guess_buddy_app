import 'package:guess_buddy_app/common/model/shared_preferences//shared_preferences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/service/api_service.dart';
import '../model/endpoint/authentication_endpoints.dart';
import '../model/request/request_sign_in_user.dart';
import '../model/request/request_sign_up_user.dart';
import '../model/response/response_sign_in_user.dart';

class AuthenticationService {
  final ApiService _apiService;

  AuthenticationService() : _apiService = ApiService();

  Future<void> signUp(RequestSignUpUser request) async {
    await _apiService.post(
      endpoint: AuthEndpoints.signUp,
      body: request.toJson(),
    );
  }

  Future<void> signIn(RequestSignInUser request) async {
    final responseMap = await _apiService.post(
      endpoint: AuthEndpoints.signIn,
      body: request.toJson(),
    );

    if (responseMap == null || responseMap['data'] == null) return;

    final response = ResponseSignInUser.fromJson(responseMap['data']);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedPreferencesKey.authToken, response.authenticationToken);
    await prefs.setString(SharedPreferencesKey.userId, response.userId);
  }
}
