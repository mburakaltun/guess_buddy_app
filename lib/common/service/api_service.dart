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

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(SharedPreferencesKey.authToken);
      final userId = prefs.getString(SharedPreferencesKey.userId);
      final lang = await LanguageHelper.getLanguage();
      final headers = {
        'Content-Type': 'application/json',
        'Accept-Language': lang,
        if (token != null) 'Authorization': 'Bearer $token',
        if (userId != null) 'X-User-Id': userId
      };

      final response = await http.post(uri, headers: headers, body: jsonEncode(body));

      Map<String, dynamic>? decoded;
      try {
        final decodedBody = utf8.decode(response.bodyBytes);
        decoded = jsonDecode(decodedBody);
      } catch (_) {
        decoded = null;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded?['data'] ?? decoded;
      } else {
        String errorMessage = decoded?['errorMessage'] ?? 'An error occurred.';
        String errorCode = decoded?['errorCode'] ?? response.statusCode.toString();
        print('API Error: $errorMessage (Code: $errorCode)');
        throw ApiException(errorCode: errorCode, errorMessage: errorMessage);
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      print('Unexpected error: $e');
      throw ApiException(errorCode: '-1', errorMessage: 'Unexpected error');
    }
  }

  Future<Map<String, dynamic>?> get({required String endpoint, Map<String, dynamic>? params}) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params?.map((k, v) => MapEntry(k, v.toString())));

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(SharedPreferencesKey.authToken);
      final userId = prefs.getString(SharedPreferencesKey.userId);
      final lang = await LanguageHelper.getLanguage();
      final headers = {
        'Content-Type': 'application/json',
        'Accept-Language': lang,
        if (token != null) 'Authorization': 'Bearer $token',
        if (userId != null) 'X-User-Id': userId
      };

      final response = await http.get(uri, headers: headers);

      Map<String, dynamic>? decoded;
      try {
        final decodedBody = utf8.decode(response.bodyBytes);
        decoded = jsonDecode(decodedBody);
      } catch (_) {
        decoded = null;
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded?['data'] ?? decoded;
      } else {
        String errorMessage = decoded?['errorMessage'] ?? 'An error occurred.';
        String errorCode = decoded?['errorCode'] ?? response.statusCode.toString();
        print('API Error: $errorMessage (Code: $errorCode)');
        throw ApiException(errorCode: errorCode, errorMessage: errorMessage);
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      print('Unexpected error: $e');
      throw ApiException(errorCode: '-1', errorMessage: 'Unexpected error');
    }
  }
}