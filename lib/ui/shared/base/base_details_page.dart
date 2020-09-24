import 'package:flutter/material.dart';

import 'base_page.dart';

mixin BaseDetailsPage<Page extends BasePage> on BaseState<Page> {
  generalDialog(
          {BuildContext context,
          bool barrierDismissible,
          String text,
          List<Widget> actions}) =>
      showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) => AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(fontSize: 19),
                ),
              ],
            ),
          ),
          actions: actions,
        ),
      );
}
