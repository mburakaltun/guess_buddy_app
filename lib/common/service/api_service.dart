import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../model/shared_preferences//shared_preferences_key.dart';
import '../model/exception/api_exception.dart';

class ApiService {
  String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  Future<Map<String, dynamic>?> post({required String endpoint, required Map<String, dynamic> body}) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    print('[ApiService] POST $uri');
    print('[ApiService] Request body: ${jsonEncode(body)}');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(SharedPreferencesKey.authToken);
      final userId = prefs.getString(SharedPreferencesKey.userId);
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
        if (userId != null) 'X-User-Id': userId
      };
      print('[ApiService] Request headers: $headers');

      final response = await http.post(uri, headers: headers, body: jsonEncode(body));
      print('[ApiService] Response status: ${response.statusCode}');
      print('[ApiService] Response body: ${response.body}');

      Map<String, dynamic>? decoded;
      try {
        final decodedBody = utf8.decode(response.bodyBytes);
        decoded = jsonDecode(decodedBody);
      } catch (_) {
        decoded = null;
      }

      String errorMessage = decoded?['errorMessage'] ?? 'An error occurred.';
      int errorCode = decoded?['errorCode'] ?? response.statusCode;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded?['data'] ?? decoded;
      } else {
        throw ApiException(message: errorMessage, code: errorCode);
      }
    } catch (e) {
      print('[ApiService] Exception: $e');
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Unexpected error', code: -1);
    }
  }

  Future<Map<String, dynamic>?> get({required String endpoint, Map<String, dynamic>? params}) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params?.map((k, v) => MapEntry(k, v.toString())));
    print('[ApiService] GET $uri');

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(SharedPreferencesKey.authToken);
      final userId = prefs.getString(SharedPreferencesKey.userId);
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
        if (userId != null) 'X-User-Id': userId
      };
      print('[ApiService] Request headers: $headers');

      final response = await http.get(uri, headers: headers);
      print('[ApiService] Response status: ${response.statusCode}');
      print('[ApiService] Response body: ${response.body}');

      Map<String, dynamic>? decoded;
      try {
        final decodedBody = utf8.decode(response.bodyBytes);
        decoded = jsonDecode(decodedBody);
      } catch (_) {
        decoded = null;
      }

      String errorMessage = decoded?['errorMessage'] ?? 'An error occurred.';
      int errorCode = decoded?['errorCode'] ?? response.statusCode;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded?['data'] ?? decoded;
      } else {
        throw ApiException(message: errorMessage, code: errorCode);
      }
    } catch (e) {
      print('[ApiService] Exception: $e');
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Unexpected error', code: -1);
    }
  }
}