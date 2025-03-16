import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:super_ecommerce/core/services/network_service.dart';
import '../errors/exceptions.dart';

class ApiService extends GetxService {
  final http.Client client;
  final NetworkService networkService;
  ApiService({required this.client, required this.networkService});

  static const String _baseUrl = 'http://192.168.0.5:8000/api/v1/';
  // static const String _baseUrl = 'http://10.0.2.2:8000/api/v1/';
  Future<void> checkInternetConnection() async {
    if (!await networkService.isConnected) {
      throw ConnectionException(
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

  // Remove auth token from headers
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
        print('GET Request: $uri');
      }

      final response =
          await client.get(uri, headers: {..._headers, ...?headers});

      return _handleResponse(response);
    } on SocketException {
      throw ConnectionException(
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
        print('POST Request: $uri');
        print('Body: $body');
      }

      final response = await client.post(
        uri,
        headers: {..._headers, ...?headers},
        body: json.encode(body),
      );

      return _handleResponse(response);
    } on SocketException {
      throw ConnectionException(
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
        print('PUT Request: $uri');
        print('Body: $body');
      }

      final response = await client.put(
        uri,
        headers: {..._headers, ...?headers},
        body: json.encode(body),
      );

      return _handleResponse(response);
    } on SocketException {
      throw ConnectionException(
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
        print('DELETE Request: $uri');
      }

      final response = await client.delete(
        uri,
        headers: {..._headers, ...?headers},
        body: body != null ? json.encode(body) : null,
      );

      return _handleResponse(response);
    } on SocketException {
      throw ConnectionException(
        message: 'No Internet connection',
      );
    }
  }

  // Handle API response
  dynamic _handleResponse(http.Response response) {
    if (kDebugMode) {
      print('Status Code: ${response.statusCode}');
      print('Response: ${response.body}');
    }
    dynamic body;
    if (response.body.isNotEmpty) {
      body = jsonDecode(response.body);
    } else {
      body = {"message": "رد فارغ"};
    }
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    } else if (response.statusCode >= 500 && response.statusCode < 600) {
      throw ServerException(
        message: body['message'] ?? 'Internal server error',
        statusCode: response.statusCode,
      );
    } else if (response.statusCode == 400) {
      throw ValidationException(
        messages: body ?? {"error": 'Bad request'},
      );
    } else if (response.statusCode == 401) {
      throw UnauthorizedException(
        message: body['message'] ?? 'Unauthorized',
      );
    } else if (response.statusCode == 403) {
      throw AuthException(message: body ?? "Forrbiden");
    } else {
      throw const CustomException(message: "خطأ غير معروف ");
    }
  }

  void dispose() {
    client.close();
  }
}
