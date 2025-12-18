import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../../core/config/api_config.dart';

class ApiService {
  late final Dio _dio;
  final _storage = GetStorage();

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _storage.read('customer_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) {
          // Handle errors globally
          return handler.next(error);
        },
      ),
    );
  }

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // POST request
  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // PUT request
  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // DELETE request
  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Error handler
  Exception _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('ການເຊື່ອມຕໍ່ຊ້າເກີນໄປ');
      case DioExceptionType.connectionError:
        return Exception('ບໍ່ສາມາດເຊື່ອມຕໍ່ເຊີບເວີໄດ້');
      case DioExceptionType.badResponse:
        final message = e.response?.data?['error'] ?? 'ເກີດຂໍ້ຜິດພາດ';
        return Exception(message);
      default:
        return Exception('ເກີດຂໍ້ຜິດພາດ');
    }
  }

  // Save token
  void saveToken(String token) {
    _storage.write('customer_token', token);
  }

  // Remove token
  void removeToken() {
    _storage.remove('customer_token');
  }

  // Check if logged in
  bool get isLoggedIn => _storage.read('customer_token') != null;
}
