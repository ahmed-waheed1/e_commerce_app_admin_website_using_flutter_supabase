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
          handler.next(options);
        },
        onResponse: (response, handler) {
          logger.i('✅ Response: ${response.statusCode} - ${response.data}');
          handler.next(response);
        },
        onError: (DioException e, handler) async {
          logger.e('❌ Error: ${e.response?.statusCode} - ${e.message}');
          handler.next(e);
        },
      ),
    );
  }
}
