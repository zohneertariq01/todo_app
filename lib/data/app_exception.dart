class AppException implements Exception {
  final message;
  final prefix;
  AppException({this.message, this.prefix});

  String toString() {
    return '$message$prefix';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message: '');
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message: '');
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message]) : super(message: '');
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message: '');
}
