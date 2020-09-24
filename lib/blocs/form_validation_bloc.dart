import 'package:flutter_base/blocs/exceptions/validation_exception.dart';

abstract class _EmailPasswordValidator {
  String email;
  String password;

  void validateEmail(String email) {
    if (_emailRegex.hasMatch(email)) {
      this.email = email;
    } else {
      throw InvalidEmailException('Email is not valid');
    }
  }

  void validatePassword(String password) {
    if (password.length <= _minNumChars) {
      throw WeakPasswordException('Password must be longer than 6 characters');
    } else {
      this.password = password;
    }
  }
}

class SignInValidationBloc with _EmailPasswordValidator {}

class SignUpValidationBloc with _EmailPasswordValidator {
  String name;
  String confirmPassword;

  void validateName(String name) {
    if (name.isEmpty) {
      throw EmptyFieldException('We need your name to make an account');
    } else {
      this.name = name;
    }
  }

  void validatePasswordMatch(String password1, String password2) {
    if (password1 != password2) {
      throw PasswordMisMatchException('The passwords don\'t match');
    } else {
      this.confirmPassword = password2;
    }
  }
}

const int _minNumChars = 6;
final RegExp _emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
