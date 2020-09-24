import 'package:flutter/material.dart';

class SignInProviderButton extends StatelessWidget {
  SignInProviderButton({
    this.providerName,
    this.iconURI,
    this.height = 50.0,
    this.width = 100.0,
    this.iconHeight = 35.0,
    this.iconWidth = 35.0,
    this.backgroundColor,
    this.textColor,
    this.onPressed,
  });

  final String providerName;
  final String iconURI;
  final double height;
  final double width;
  final double iconHeight;
  final double iconWidth;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      constraints: BoxConstraints.expand(height: height),
      shape: new RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(height / 3),
        ),
      ),
      fillColor: backgroundColor,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 24.0,
              ),
              child: Image.asset(
                iconURI,
                width: iconWidth,
                height: iconHeight,
              ),
            ),
            Text(
              "Sign in with $providerName",
              style: TextStyle(
                fontFamily: 'Roboto',
                color: textColor,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
