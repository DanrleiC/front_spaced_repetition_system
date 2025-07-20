import 'package:dio/dio.dart';
import 'api_service_exeption.dart';

class ApiService {
  final String baseUrl;
  final Map<String, String> defaultHeaders;
  final Dio _dio;

  ApiService({
    this.baseUrl = "https://back-spaced-repetition-system.onrender.com",
    this.defaultHeaders = const {},
  }) : _dio = Dio(BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Content-Type': 'application/json',
            ...defaultHeaders,
          },
        ));

  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  Future<dynamic> post(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: body,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  Future<dynamic> put(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: body,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: body,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    }
  }

  Never _handleDioError(DioException e) {
    final response = e.response;
    final statusCode = response?.statusCode ?? 500;
    final message = response?.data.toString() ?? e.message;
    throw HttpException(statusCode: statusCode, message: message.toString());
  }
}

