import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/shared_preferences//shared_preferences_key.dart';
import '../model/exception/api_exception.dart';
import '../utility/language_utility.dart';

class ApiService {
  String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  Future<Map<String, dynamic>?> post({required String endpoint, required Map<String, dynamic> body}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders();
    return _makeRequest(http.post(uri, headers: headers, body: jsonEncode(body)));
  }

  Future<Map<String, dynamic>?> put({required String endpoint, required Map<String, dynamic> body}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders();
    return _makeRequest(http.put(uri, headers: headers, body: jsonEncode(body)));
  }

  Future<Map<String, dynamic>?> delete({required String endpoint, required Map<String, dynamic> body}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = await _getHeaders();
    return _makeRequest(http.delete(uri, headers: headers, body: jsonEncode(body)));
  }

  Future<Map<String, dynamic>?> get({required String endpoint, Map<String, dynamic>? params}) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params?.map((k, v) => MapEntry(k, v.toString())));
    final headers = await _getHeaders();
    return _makeRequest(http.get(uri, headers: headers));
  }

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(SharedPreferencesKey.authToken);
    final userId = prefs.getString(SharedPreferencesKey.userId);
    final roomId = prefs.getString(SharedPreferencesKey.roomId);
    final lang = await LanguageHelper.getLanguage();

    return {
      'Content-Type': 'application/json',
      'Accept-Language': lang,
      if (token != null) 'Authorization': 'Bearer $token',
      if (userId != null) 'X-User-Id': userId,
      if (roomId != null) 'X-Room-Id': roomId,
    };
  }

  Map<String, dynamic>? _decodeResponse(http.Response response) {
    try {
      final decodedBody = utf8.decode(response.bodyBytes);
      return jsonDecode(decodedBody);
    } catch (_) {
      return null;
    }
  }

  void _handleErrorResponse(http.Response response, Map<String, dynamic>? decoded) {
    final errorMessage = decoded?['errorMessage'] ?? 'An error occurred.';
    final errorCode = decoded?['errorCode'] ?? response.statusCode.toString();
    print('API Error: $errorMessage (Code: $errorCode)');
    throw ApiException(errorCode: errorCode, errorMessage: errorMessage);
  }

  Future<Map<String, dynamic>?> _makeRequest(Future<http.Response> request) async {
    try {
      final response = await request;
      final decoded = _decodeResponse(response);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded?['data'] ?? decoded;
      } else {
        _handleErrorResponse(response, decoded);
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      print('Unexpected error: $e');
      throw ApiException(errorCode: '-1', errorMessage: 'Unexpected error');
    }
    return null;
  }
}