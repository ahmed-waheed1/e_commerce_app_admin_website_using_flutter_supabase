import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import 'dio_config.dart';

class DioService {
  final Dio _dio = DioConfig.dio;
  Dio get dio => _dio;

  DioService() {
    DioConfig.addInterceptors();
  }

  Future<Either<String, dynamic>> post(
    String endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    return _handleRequest(
      () => _dio.post(
        endpoint,
        data: _formatData(data),
        queryParameters: queryParameters,
        options: Options(),
      ),
    );
  }

  Future<Either<String, dynamic>> put(String endpoint, {dynamic data}) async {
    return _handleRequest(() => _dio.put(endpoint, data: _formatData(data)));
  }

  Future<Either<String, dynamic>> _handleRequest(
    Future<Response> Function() request,
  ) async {
    try {
      final response = await request();
      return Right(response.data);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<String, dynamic>> delete(String endpoint) async {
    return _handleRequest(() => _dio.delete(endpoint));
  }

  Future<Either<String, dynamic>> patch(String endpoint, {dynamic data}) async {
    return _handleRequest(() => _dio.patch(endpoint, data: _formatData(data)));
  }

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response;
    } on DioException catch (e) {
      throw Exception(_handleError(e));
    }
  }

  String _handleError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response?.statusCode ?? 500;
      final errorMessage =
          e.response?.data['message'] ?? 'Something went wrong';

      if (statusCode == 401) return 'Unauthorized access. Please log in again.';
      if (statusCode == 403) {
        return 'You do not have permission to perform this action.';
      }
      if (statusCode == 404) return 'Requested resource not found.';
      if (statusCode == 500) return 'Server error. Please try again later.';

      return errorMessage;
    } else if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return 'Connection timed out. Please check your internet.';
    } else if (e.type == DioExceptionType.badResponse) {
      return 'Invalid response from server.';
    } else if (e.type == DioExceptionType.cancel) {
      return 'Request was cancelled.';
    } else {
      return e.message ?? 'Unexpected error occurred.';
    }
  }

  dynamic _formatData(dynamic data) {
    if (data is Map<String, dynamic>) {
      return FormData.fromMap(data);
    }
    return data;
  }
}
