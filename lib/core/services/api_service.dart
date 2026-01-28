import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:super_ecommerce/core/services/network_service.dart';
import '../errors/exceptions.dart';

abstract class ApiService {
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  });

  // POST request
  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
  // PUT request
  Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });

  // DELETE request
  Future<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  });
  void setAuthToken(String token);
  void removeAuthToken();
}

class ApiServiceImpByHttp extends GetxService implements ApiService {
  ApiServiceImpByHttp({required this.client, required this.networkService});

  Logger logger = Get.find();
  final http.Client client;
  final NetworkService networkService;

  // static const String _baseUrl = 'http://192.168.0.5:8000/api/v1/';
  static const String _baseUrl = 'http://10.0.2.2:8000/api/v1/';
  Future<void> checkInternetConnection() async {
    if (!await networkService.isConnected) {
      throw const ConnectionException(
        message: 'No Internet connection',
      );
    }
  }

  final Map<String, String> _headers = {
    'Content-Type': 'application/json; charset=utf-8',
    'Accept': 'application/json',
  };

  // Add auth token to headers
  void setAuthToken(String token) {
    _headers['Authorization'] = 'Bearer $token';
  }

  //Remove auth token from headers
  void removeAuthToken() {
    _headers.remove('Authorization');
  }

  // GET request
  Future<dynamic> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    await checkInternetConnection();
    try {
      final uri = Uri.parse('$_baseUrl$endpoint').replace(
        queryParameters: queryParameters,
      );

      if (kDebugMode) {
        logger.d('GET Request: $uri');
      }

      final response =
          await client.get(uri, headers: {..._headers, ...?headers});

      return _handleResponse(response);
    } on SocketException {
      throw const ConnectionException(
        message: 'No Internet connection',
      );
    }
  }

  // POST request
  Future<dynamic> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    await checkInternetConnection();
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');

      if (kDebugMode) {
        logger.d('POST Request: $uri');
        logger.d('Body: $body');
      }

      final response = await client.post(
        uri,
        headers: {..._headers, ...?headers},
        body: json.encode(body),
      );

      return _handleResponse(response);
    } on SocketException {
      throw const ConnectionException(
        message: 'No Internet connection',
      );
    }
  }

  // PUT request
  Future<dynamic> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    await checkInternetConnection();
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');

      if (kDebugMode) {
        logger.d('PUT Request: $uri');
        logger.d('Body: $body');
      }

      final response = await client.put(
        uri,
        headers: {..._headers, ...?headers},
        body: json.encode(body),
      );

      return _handleResponse(response);
    } on SocketException {
      throw const ConnectionException(
        message: 'No Internet connection',
      );
    }
  }

  // DELETE request
  Future<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    await checkInternetConnection();
    try {
      final uri = Uri.parse('$_baseUrl$endpoint');

      if (kDebugMode) {
        logger.d('DELETE Request: $uri');
      }

      final response = await client.delete(
        uri,
        headers: {..._headers, ...?headers},
        body: body != null ? json.encode(body) : null,
      );

      return _handleResponse(response);
    } on SocketException {
      throw const ConnectionException(
        message: 'No Internet connection',
      );
    }
  }

  void dispose() {
    client.close();
  }

  String _extractErrorMessage(dynamic body, String defaultMessage) {
    if (body == null) return defaultMessage;

    if (body is Map<String, dynamic>) {
      return body['message']?.toString() ??
          body['detail']?.toString() ??
          body['error']?.toString() ??
          defaultMessage;
    } else if (body is String && body.isNotEmpty) {
      return body;
    }
    return defaultMessage;
  }

  dynamic _handleResponse(http.Response response) {
    if (kDebugMode) {
      logger.d('API Response from URL: ${response.request?.url}');
      logger.d('Status Code: ${response.statusCode}');
      logger.d('Headers: ${response.headers}');
      logger.d('Response Body: ${response.body}');
    }

    dynamic responseBody;
    try {
      if (response.body.isNotEmpty) {
        responseBody = jsonDecode(response.body);
      } else {
        responseBody = null;
      }
    } on FormatException catch (e) {
      if (response.statusCode >= 400) {
        throw CustomException(
          message:
              'فشل تحليل استجابة الخادم (ليست JSON صالحة). المحتوى: ${response.body}',
          statusCode: response.statusCode,
        );
      } else {
        throw CustomException(
            message: 'تمت الاستجابة بنجاح ولكن فشل تحليل المحتوى كـ JSON.',
            statusCode: response.statusCode);
      }
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return responseBody;
    }

    final String defaultErrorMessage =
        'حدث خطأ غير متوقع (StatusCode: ${response.statusCode}).';

    final String errorMessage =
        _extractErrorMessage(responseBody, defaultErrorMessage);

    switch (response.statusCode) {
      case 400:
        throw ValidationException(
          validationMessages: responseBody,
          statusCode: 400,
          message: _extractErrorMessage(
              responseBody, "البيانات المقدمة غير صالحة أو غير مكتملة."),
        );

      case 401:
        throw UnauthorizedException(message: errorMessage, statusCode: 401);

      case 403:
        throw ForbiddenException(message: errorMessage, statusCode: 403);

      case 404:
        throw CustomException(
          message:
              _extractErrorMessage(responseBody, "المورد المطلوب غير موجود."),
          statusCode: 404,
        );

      case 422:
        throw ValidationException(
          validationMessages: responseBody,
          message: _extractErrorMessage(
              responseBody, "فشل التحقق من صحة البيانات المرسلة."),
          statusCode: 422,
        );

      case 429:
        throw TooManyRequestException(
          messages: responseBody is Map<String, dynamic>
              ? responseBody
              : {'response_body': responseBody},
          message: _extractErrorMessage(
              responseBody, "تجاوزت الحد الأقصى لعدد الطلبات الممكنة."),
          statusCode: 429,
        );

      case >= 500 && < 600:
        throw ServerException(
          message: errorMessage,
          statusCode: response.statusCode,
        );

      default:
        throw UnhandledException(
          response: response.body,
          statusCode: response.statusCode,
        );
    }
  }
}
