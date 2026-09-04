abstract class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException([super.message = 'Network error occurred']);
}

class ServerException extends AppException {
  final int? statusCode;
  ServerException([super.message = 'Server error occurred', this.statusCode]);
}

class NotFoundException extends AppException {
  NotFoundException([super.message = 'Resource not found']);
}

class ParseException extends AppException {
  ParseException([super.message = 'Error parsing response']);
}

class UnexpectedException extends AppException {
  UnexpectedException([super.message = 'An unexpected error occurred']);
}
