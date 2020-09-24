class AuthException extends Error {
  final String message;
  AuthException(this.message);
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException(String message) : super(message);
}

class EmailInUseException extends AuthException {
  EmailInUseException(String message) : super(message);
}

class UserDisabledException extends AuthException {
  UserDisabledException(String message) : super(message);
}

class UserNotFoundException extends AuthException {
  UserNotFoundException(String message) : super(message);
}
