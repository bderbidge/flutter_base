import 'package:flutter/material.dart';
import 'package:flutter_base/ui/theme.dart';

OutlineInputBorder textFieldFocusedBorder() {
  return new OutlineInputBorder(
    borderSide: new BorderSide(
      width: 2.0,
      color: Colors.blue,
    ),
  );
}

OutlineInputBorder textFieldNormalBorder() {
  return new OutlineInputBorder(
    borderSide: new BorderSide(
      width: 3.0,
      color: CompanyColors.black,
    ),
  );
}

OutlineInputBorder textFieldFocusedErrorBorder() {
  return new OutlineInputBorder(
    borderSide: new BorderSide(
      width: 2.0,
      color: CompanyColors.notificationRed,
    ),
  );
}
