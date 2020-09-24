import 'package:flutter/widgets.dart';

class ExternalAuthProviderButton extends StatelessWidget {
  ExternalAuthProviderButton(this.onTap, this.providerName,
      {this.width, this.height, this.decoration});

  final GestureTapCallback onTap;
  final String providerName;
  final double width;
  final double height;
  final BoxDecoration decoration;

  final double _imagePadding = 15.0;
  final double _marginVert = 8.0;
  final double _marginHor = 16.0;

  @override
  Widget build(BuildContext context) {
    final double width = this.width ?? 30.0;
    final double height = this.height ?? 30.0;
    final BoxDecoration boxDecoration = this.decoration ??
        BoxDecoration(
          shape: BoxShape.circle,
        );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:
            EdgeInsets.symmetric(vertical: _marginVert, horizontal: _marginHor),
        padding: EdgeInsets.all(this._imagePadding),
        decoration: boxDecoration,
        child: Image(
          width: width,
          height: height,
          fit: BoxFit.fill,
          image: AssetImage("assets/icons/${providerName}_logo.png"),
        ),
      ),
    );
  }
}
