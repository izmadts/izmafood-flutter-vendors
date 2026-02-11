// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart' hide Response, FormData;
import 'package:get_storage/get_storage.dart';
import 'package:izma_foods_vendor/config/api_constants.dart';
import 'package:izma_foods_vendor/config/string_constants.dart';
import 'package:izma_foods_vendor/core/logger.extension.dart';
import 'package:izma_foods_vendor/helpers/api_exception.dart';
import '../pages/splash_page.dart';
import '../controllers/auth_controller.dart';
import 'package:izma_foods_vendor/config/constants.dart' as config;

enum Method { POST, GET, PUT, DELETE, PATCH }

class APIHelper {
  static late Dio _dio;

  static header({String? token, bool isFormData = false}) {
    final headers = {
      "Accept": "application/json",
    };

    // Only set Content-Type if not FormData (Dio will set it automatically for FormData)
    if (!isFormData) {
      headers["Content-Type"] = "application/x-www-form-urlencoded";
    }

    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    }

    return headers;
  }

  static Future<void> init() async {
    // Try to get from dotenv, fallback to constant
    String baseUrl;
    try {
      baseUrl = dotenv.env[ApiConst.APIBaseURL] ?? config.kBaseApiUrl;
    } catch (e) {
      baseUrl = config.kBaseApiUrl;
    }

    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: header(),
      ),
    );

    initInterceptors();
  }

  static void initInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (requestOptions, handler) {
          "REQUEST[${requestOptions.method}] => PATH: ${requestOptions.path}"
                  "=> REQUEST VALUES: ${requestOptions.queryParameters} => HEADERS: ${requestOptions.headers}"
              .logInfo();

          return handler.next(requestOptions);
        },
        onResponse: (response, handler) {
          "RESPONSE[${response.statusCode}] => DATA: ${response.data}"
              .logInfo();

          return handler.next(response);
        },
        onError: (err, handler) async {
          "Error[${err.response?.statusCode}]".logInfo();

          final statusCode = err.response?.statusCode;

          if (statusCode == 401) {
            // clear storage
            await GetStorage().erase();

            // redirect to login using GetX
            Get.offAll(() => SplashPage());
          }

          return handler.next(err);
        },
      ),
    );
  }

  Future<Response> request({
    required String url,
    required Method method,
    params,
    String? token,
    Function(int?, int?)? onProgressSend,
  }) async {
    try {
      // Try to get from dotenv, fallback to constant
      String baseUrl;
      try {
        baseUrl = dotenv.env[ApiConst.APIBaseURL] ?? config.kBaseApiUrl;
      } catch (e) {
        baseUrl = config.kBaseApiUrl;
      }

      final response = await compute(
        (Map<String, dynamic> data) {
          return _performHttpRequest(
            data,
            baseUrl,
            onProgressSend: onProgressSend,
          );
        },
        {
          'url': url,
          'method': method,
          'params': params,
          'token': token,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 401) {
        throw APIException(
          message: 'Unauthorized',
          statusCode: response.statusCode!,
        );
      } else if (response.statusCode == 500) {
        throw APIException(
          message: 'Server Error',
          statusCode: response.statusCode!,
        );
      } else if (response.statusCode == 422) {
        throw APIException(
          message: 'Unprocessable content',
          statusCode: response.statusCode!,
        );
      } else {
        throw APIException(
          message: 'Something went wrong',
          statusCode: response.statusCode!,
        );
      }
    } on SocketException catch (_) {
      throw const APIException(
        message: 'No Internet Connection',
        statusCode: 500,
      );
    } on FormatException catch (_) {
      throw const APIException(
        message: 'Bad response format',
        statusCode: 500,
      );
    } on DioException catch (e) {
      final message = handleDioError(e);
      throw APIException(
        message: message,
        statusCode: e.response?.statusCode ?? 500,
      );
    } on APIException {
      rethrow;
    } catch (e) {
      // final message = handleDioError(e);
      throw APIException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  static Future<Response> _performHttpRequest(
      Map<String, dynamic> data, String baseUrl,
      {Function(int?, int?)? onProgressSend}) async {
    final token = data['token'] ?? "";
    final params = data['params'];
    final isFormData = params is FormData;

    Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: header(token: token, isFormData: isFormData),
      ),
    );

    final url = data['url'];
    final method = data['method'];

    try {
      Response response;

      switch (method) {
        case Method.POST:
          response = await dio.post(
            url,
            data: params,
            onSendProgress: onProgressSend,
          );
          break;

        case Method.DELETE:
          response = await dio.delete(
            url,
            data: params,
          );
          break;

        case Method.PATCH:
          response = await dio.patch(url);
          break;

        default:
          response = await dio.get(
            url,
            queryParameters: params,
          );
          break;
      }

      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        GetStorage().remove(StringConstants.token);
      }

      final message = handleDioError(e);
      throw Exception(message);
    }
  }

  static String handleDioError(DioException e) {
    // "DioError: $e".logError();

    if (e.type == DioExceptionType.unknown) {
      const message = "There is no internet connection";
      message.logError();
      return message;
    } else if (e.type == DioExceptionType.connectionError) {
      const message = "There is no internet connection";
      message.logError();
      return message;
    } else if (e.type == DioExceptionType.cancel) {
      const message = "Request to API server was cancelled";
      message.logError();
      return message;
    } else if (e.type == DioExceptionType.connectionTimeout) {
      const message = "Connection timeout with API server";
      message.logError();
      return message;
    } else if (e.type == DioExceptionType.receiveTimeout) {
      const message = "Receive timeout in connection with API server";
      message.logError();
      return message;
    } else if (e.type == DioExceptionType.sendTimeout) {
      const message = "Send timeout in connection with API server";
      message.logError();
      return message;
    } else if (e.type == DioExceptionType.badResponse) {
      if (e.response?.statusCode == 401) {
        const message = StringConstants.sessionExpired;
        message.logError();
        return message;
      } else {
        final message1 = "${e.response}";
        message1.logError();
        return message1;
      }
    } else {
      return "DioError: Something went wrong";
    }
  }

  static Dio get dio {
    return _dio;
  }

  // Helper methods to maintain backward compatibility with existing code
  Future<dynamic> post(String url,
      [Map<String, dynamic> data = const {}]) async {
    try {
      final response = await request(
        url: url,
        method: Method.POST,
        params: data,
      );

      // Handle the old response format check
      if (response.data != null && response.data['status'] == false) {
        throw APIException(
          message: response.data['messege'] ?? 'Request failed',
          statusCode: response.statusCode ?? 500,
        );
      }

      return response.data ?? {};
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  Future<dynamic> get(String url,
      [Map<String, dynamic> data = const {}]) async {
    try {
      final response = await request(
        url: url,
        method: Method.GET,
        params: data,
      );

      // Handle the old response format check
      if (response.data != null && response.data['status'] == false) {
        throw APIException(
          message: response.data['messege'] ?? 'Request failed',
          statusCode: response.statusCode ?? 500,
        );
      }

      return response.data ?? {};
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }

  Future<dynamic> postAuthenticated(String url,
      [Map<String, dynamic> data = const {}]) async {
    try {
      // Get token from AuthController - use try-catch to avoid circular dependency issues
      String? token;
      try {
        final authController = Get.find<AuthController>();
        token = authController.loginModel.value?.data?.token;
      } catch (e) {
        // AuthController not available, continue without token
      }

      final requestData = Map<String, dynamic>.from(data);
      if (token != null) {
        requestData['access_token'] = token;
      }

      final response = await request(
        url: url,
        method: Method.POST,
        params: requestData,
        token: token,
      );

      // Handle the old response format check
      if (response.data != null && response.data['status'] == false) {
        throw APIException(
          message: response.data['messege'] ?? 'Request failed',
          statusCode: response.statusCode ?? 500,
        );
      }

      return response.data ?? {};
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}

// Type alias for backward compatibility with existing code
typedef ApiHelper = APIHelper;
