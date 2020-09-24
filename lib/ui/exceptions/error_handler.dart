import 'package:flutter/material.dart';
import 'package:flutter_base/blocs/exceptions/validation_exception.dart';
import 'package:flutter_base/services/auth/auth_exception.dart';

import 'package:flutter_base/services/exceptions/network_exception.dart';

class ErrorHandler {
  Error e;
  //go through all custom errors and return the corresponding error message
  static ErrorMessage errorMessage(dynamic error) {
    if (error is NetworkError) {
      return ErrorMessage(message: error.message);
    }

    if (error is InvalidCredentialsException) {
      return ErrorMessage(message: error.message);
    }
    if (error is WeakPasswordException) {
      return ErrorMessage(message: error.message);
    }
    if (error is EmailInUseException) {
      return ErrorMessage(message: error.message);
    }
    if (error is UserDisabledException) {
      return ErrorMessage(message: error.message);
    }
    if (error is UserNotFoundException) {
      return ErrorMessage(message: error.message);
    }
    if (error is PasswordMisMatchException) {
      return ErrorMessage(message: error.message);
    }
    if (error is InvalidEmailException) {
      return ErrorMessage(message: error.message);
    }

    // throw unexpected error.
    throw error;
  }

  //Display an AlertDialog with the error message
  static void showErrorDialog(BuildContext context, dynamic error) {
    if (error == null) {
      return;
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(errorMessage(error).title),
          content: Text(errorMessage(error).message),
        );
      },
    );
  }

  //Display an snackBar with the error message
  static void showErrorSnackBar(BuildContext context, dynamic error) {
    if (error == null) {
      return;
    }
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${errorMessage(error).message}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold",
          ),
        ),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }
}

class ErrorMessage {
  final String title;
  final String message;

  ErrorMessage({this.title, this.message});
}
