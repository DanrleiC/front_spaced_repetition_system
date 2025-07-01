import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api_service_exeption.dart';

class ApiService {
  final String baseUrl;
  final Map<String, String> defaultHeaders;

  ApiService({
    this.baseUrl = "https://back-spaced-repetition-system.onrender.com",
    this.defaultHeaders = const {},
  });

  Map<String, String> _buildHeaders([Map<String, String>? headers]) {
    return {
      'Content-Type': 'application/json',
      ...defaultHeaders,
      if (headers != null) ...headers,
    };
  }

  Future<dynamic> get(String endpoint, { Map<String, String>? headers, Map<String, dynamic>? queryParameters }) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: queryParameters);
    final response = await http.get(uri, headers: _buildHeaders(headers));
    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, { Map<String, String>? headers, dynamic body }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(
      uri,
      headers: _buildHeaders(headers),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> put( String endpoint, { Map<String, String>? headers, dynamic body }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await http.put(
      uri,
      headers: _buildHeaders(headers),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint, { Map<String, String>? headers, dynamic body }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await http.delete(
      uri,
      headers: _buildHeaders(headers),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final body = response.body;

    if (statusCode >= 200 && statusCode < 300) {
      return jsonDecode(body);
    } else {
      throw HttpException(
        statusCode: statusCode,
        message: body,
      );
    }
  }
}