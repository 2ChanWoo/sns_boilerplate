class AppException implements Exception {
  final String? code;
  final String? message;
  final String? details;

  AppException({this.code, this.message, this.details});

  String toString() {
    return "[$code]: $message \n $details";
  }
}

class NoContentsException extends AppException {
  NoContentsException(String? details)
      : super(
    code: "no-contents",
    message: "No Contents",
    details: details,
  );
}

class FetchDataException extends AppException {
  FetchDataException(String? details)
      : super(
    code: "fetch-data",
    message: "Error During Communication",
    details: details,
  );
}

class BadRequestException extends AppException {
  BadRequestException(String? details)
      : super(
    code: "invalid-request",
    message: "Invalid Request",
    details: details,
  );
}

class UnauthorisedException extends AppException {
  UnauthorisedException(String? details)
      : super(
    code: "unauthorised",
    message: "Unauthorised",
    details: details,
  );
}

/// 404
class NotFoundException extends AppException {
  NotFoundException(String? details)
      : super(
    code: "not-found",
    message: "Not Found",
    details: details,
  );
}

/// 409
class ConflictException extends AppException {
  ConflictException(String? details)
      : super(
    code: "conflict",
    message: "Conflict",
    details: details,
  );
}

class InvalidInputException extends AppException {
  InvalidInputException(String? details)
      : super(
    code: "invalid-input",
    message: "Invalid Input",
    details: details,
  );
}

class AuthenticationException extends AppException {
  AuthenticationException(String? details)
      : super(
    code: "authentication-failed",
    message: "Authentication Failed",
    details: details,
  );
}

class TimeOutException extends AppException {
  TimeOutException(String? details)
      : super(
    code: "request-timeout",
    message: "Request TimeOut",
    details: details,
  );
}

class DuplicatedRequestException extends AppException {
  DuplicatedRequestException(String? details)
      : super(
    code: "duplecated-request",
    message: "Duplicated Request",
    details: details,
  );
}

class InternalServerErrorException extends AppException {
  InternalServerErrorException(String? details)
      : super(
    code: "InternalServerErrorException",
    message: "InternalServerErrorException",
    details: details,
  );
}
