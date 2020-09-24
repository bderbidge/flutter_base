class ValidationException extends Error {
  final String message;
  ValidationException(this.message);
}

class EmptyFieldException extends ValidationException {
  EmptyFieldException(String message) : super(message);
}

class InvalidEmailException extends ValidationException {
  InvalidEmailException(String message) : super(message);
}

class WeakPasswordException extends ValidationException {
  WeakPasswordException(String message) : super(message);
}

class PasswordMisMatchException extends ValidationException {
  PasswordMisMatchException(String message) : super(message);
}
