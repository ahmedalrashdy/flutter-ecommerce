class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException({required this.message, this.statusCode});
}

class ConnectionException implements Exception {
  final String message;

  ConnectionException({required this.message});
}

class CacheException implements Exception {
  final String message;

  CacheException({required this.message});
}

class ValidationException implements Exception {
  final Map<String, dynamic> messages;

  const ValidationException({required this.messages});
}

class AuthException implements Exception {
  final String message;
  final int? statusCode;

  AuthException({required this.message, this.statusCode});
}

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException({required this.message});
}

class CustomException implements Exception {
  final String message;
  const CustomException({required this.message});
}
