import 'package:david_weijian_test/core/constants/api_constants.dart';
import 'package:david_weijian_test/core/services/secure_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
    ),
  );

  static void init() {
    // Add interceptors
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add auth token if exists
          final token = await _getAuthToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          throw _handleError(e); // Convert to user-friendly errors
        },
      ),
    );
  }

  static Future<String?> _getAuthToken() async {
    SecureStorageService secureStorage = SecureStorageService();
    String? token = await secureStorage.getAccessToken();

    debugPrint('Token: $token');

    // Check if token is not null and not empty
    if (token != null && token.isNotEmpty) {
      return token;
    }
    return null;
  }

  static Exception _handleError(DioException e) {
    if (e.response?.statusCode == 401) {
      return Exception('Session expired - Please login again');
    }
    return Exception('Network error: ${e.message}');
  }

  // Example GET request
  Future<Response> get(String path) async => _dio.get(path);

  // Example POST request
  Future<Response> post(String path, dynamic data) async =>
      _dio.post(path, data: data);

  // Example PUT request
  Future<Response> put(String path, dynamic data) async =>
      _dio.put(path, data: data);

  // Example DELETE request
  Future<Response> delete(String path) async => _dio.delete(path);
}
