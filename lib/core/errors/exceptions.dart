abstract class AppException implements Exception {
  final String message;

  final int? statusCode;

  const AppException({required this.message, this.statusCode});

  @override
  String toString() {
    String result = '$runtimeType';
    if (statusCode != null) {
      result += ' (StatusCode: $statusCode)';
    }
    result += ': $message';
    return result;
  }
}

class ServerException extends AppException {
  const ServerException({required super.message, super.statusCode});
}

class ConnectionException extends AppException {
  const ConnectionException({required super.message}) : super(statusCode: null);
}

class TooManyRequestException extends AppException {
  final Map<String, dynamic> messages;

  const TooManyRequestException({
    required this.messages,
    super.message = "تجاوزت الحد الأقصى لعدد الطلبات الممكنة للخادم",
    super.statusCode = 429,
  });

  @override
  String toString() {
    String result = super.toString();

    result += ' | Details: $messages';
    return result;
  }
}

class ValidationException extends AppException {
  final Map<String, dynamic> validationMessages;

  const ValidationException({
    required this.validationMessages,
    super.message = "البيانات المقدمة غير صالحة أو غير مكتملة.",
    super.statusCode,
  });

  @override
  String toString() {
    return '${super.toString()} | Errors: $validationMessages';
  }
}

class CacheException extends AppException {
  const CacheException({required super.message}) : super(statusCode: null);
}

class AuthException extends AppException {
  const AuthException({required super.message, super.statusCode});
}

class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = "غير مصرح لك بالوصول. قد تحتاج إلى تسجيل الدخول.",
    super.statusCode = 401,
  });
}

class ForbiddenException extends AppException {
  const ForbiddenException({
    super.message =
        "ليس لديك الصلاحية الكافية لتنفيذ هذا الإجراء أو الوصول لهذا المحتوى.",
    super.statusCode = 403,
  });
}

class CustomException extends AppException {
  const CustomException({required super.message, super.statusCode});
}

class UnhandledException extends AppException {
  final String response;
  const UnhandledException({required this.response, super.statusCode})
      : super(message: "");
}
