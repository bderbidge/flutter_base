import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    Key key,
    @required this.text,
    this.height = 50.0,
    this.width = 100.0,
    this.elevation = 2.0,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final double height;
  final double width;
  final double elevation;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: width,
      height: height,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0))),
      child: RaisedButton(
        // disabledColor: CompanyColors.turquoise['main50'],
        disabledTextColor: Colors.white70,
        // color: CompanyColors.turquoise['main'],
        // textColor: CompanyColors.white,
        elevation: elevation,
        child: Text(
          text,
          // style: CompanyTypography.primaryButtonTextStyle,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
