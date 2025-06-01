import '../endpoints/authentication_endpoints.dart';
import 'api_service.dart';

class AuthenticationService {
  final ApiService _apiService;

  AuthenticationService() : _apiService = ApiService();

  Future<void> signUp({required String email, required String password, required confirmPassword}) async {
    await _apiService.post(endpoint: AuthEndpoints.signUp, body: {'email': email, 'password': password, 'confirmPassword': confirmPassword});
  }

  Future<void> signIn({required String email, required String password}) async {
    await _apiService.post(endpoint: AuthEndpoints.signIn, body: {'email': email, 'password': password});
  }
}
