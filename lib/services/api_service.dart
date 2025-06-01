import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  Future<http.Response> post({
    required String endpoint,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    final url = Uri.parse(baseUrl + endpoint);

    final defaultHeaders = {
      'Content-Type': 'application/json',
    };

    if (headers != null) {
      defaultHeaders.addAll(headers);
    }

    final response = await http.post(
      url,
      headers: defaultHeaders,
      body: jsonEncode(body),
    );

    return response;
  }
}
