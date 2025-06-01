import 'package:guess_buddy_app/constants/shared_preferences_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../endpoints/authentication_endpoints.dart';
import 'api_service.dart';

class AuthenticationService {
  final ApiService _apiService;

  AuthenticationService() : _apiService = ApiService();

  Future<void> signUp({required String email, required String password, required confirmPassword}) async {
    await _apiService.post(endpoint: AuthEndpoints.signUp, body: {'email': email, 'password': password, 'confirmPassword': confirmPassword});
  }

  Future<void> signIn({required String email, required String password}) async {
    final response = await _apiService.post(endpoint: AuthEndpoints.signIn, body: {'email': email, 'password': password});
    final token = response?['data']?['authenticationToken'];
    final userId = response?['data']?['userId'];
    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(SharedPreferencesKey.authToken, token);
      await prefs.setString(SharedPreferencesKey.userId, userId);
    }
  }
}
