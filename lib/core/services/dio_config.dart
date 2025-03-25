import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../utils/app_constants.dart';
import '../utils/secret_data.dart';
import 'end_points.dart';
import 'service_locator.dart';

class DioConfig {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.apiBaseUrl,
      connectTimeout: const Duration(seconds: AppConstants.connectTimeout),
      receiveTimeout: const Duration(seconds: AppConstants.receiveTimeout),
      headers: {
        'apikey': anonKey,
        'Authorization': 'Bearer $anonKey',
      },
    ),
  );

  static Dio get dio => _dio;

  static void addInterceptors() {
    final logger = locator<Logger>();
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          logger.i('🔹 Request: ${options.method} ${options.path}');
          logger.i('🔹 Headers: ${options.headers}');
          logger.i('🔹 Query Parameters: ${options.queryParameters}');
          logger.i('🔹 Data: ${options.data}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          logger.i('✅ Response: ${response.statusCode} - ${response.data}');
          logger.i('✅ Headers: ${response.headers}');
          logger.i(
              '✅ Request: ${response.requestOptions.method} ${response.requestOptions.path}');
          logger.i(
              '✅ Query Parameters: ${response.requestOptions.queryParameters}');
          handler.next(response);
        },
        onError: (DioException e, handler) async {
          logger.e('❌ Error: ${e.response?.statusCode} - ${e.message}');
          logger.e(
              '❌ Request: ${e.requestOptions.method} ${e.requestOptions.path}');
          logger.e('❌ Query Parameters: ${e.requestOptions.queryParameters}');
          logger.e('❌ Data: ${e.requestOptions.data}');
          logger.e('❌ Headers: ${e.requestOptions.headers}');
          handler.next(e);
        },
      ),
    );
  }
}
