import 'package:flutter/material.dart';

import 'primary_button.dart';

class ActionButtonBar extends StatelessWidget {
  // The height of the bar, default is 70.0
  final double barHeight;

  // The width of the button described as a ratio of the available area, default is 0.75 or 75%
  final double buttonWidthRatio;

  // The elevation of the button, default is 0.0
  final double buttonElevation;

  // An optional infoWidget to display to the left of the button
  // In the case of the vendor info page it would be the ReviewStars widget
  final Widget infoWidget;

  // The text in the button. The button is displayed on the right
  final String buttonText;

  // How much horizontal space is available. See [Row.mainAxisSize].
  final MainAxisSize mainAxisSize;

  // The callback function for the button
  // Set to null to create a 'disabled' effect
  final VoidCallback onPressed;

  // The callback function for the infoWidget
  final VoidCallback onInfoPressed;

  static const double _defaultButtonWidthRatio = 0.75;
  static const double _backUpButtonWidthRatio = 0.50;

  ActionButtonBar({
    Key key,
    this.mainAxisSize = MainAxisSize.min,
    this.barHeight = 40.0,
    @required this.buttonText,
    this.buttonWidthRatio = _defaultButtonWidthRatio,
    this.buttonElevation = 0.0,
    this.infoWidget,
    @required this.onPressed,
    this.onInfoPressed,
  })  : assert(buttonText != null),
        assert(buttonWidthRatio < 1.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // We divide by 4.0 because we want half of the average of the left and right padding.
    final double _paddingUnit =
        ButtonTheme.of(context).padding.horizontal / 4.0;
    Size _deviceSize = MediaQuery.of(context).size;

    return Container(
      width: _deviceSize.width,
      padding: EdgeInsets.symmetric(
        vertical: _paddingUnit,
        horizontal: 1.5 * _paddingUnit,
      ),
      //
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double _adjustedButtonWidthRatio =
              infoWidget != null ? _backUpButtonWidthRatio : buttonWidthRatio;

          MainAxisAlignment _adjustedAlignment = infoWidget != null
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.center;

          return Row(
            mainAxisAlignment: _adjustedAlignment,
            mainAxisSize: mainAxisSize,
            children: <Widget>[
              (infoWidget != null)
                  ? GestureDetector(
                      onTap: onInfoPressed,
                      child: infoWidget,
                    )
                  : null, // This will be removed from the list
              Container(
                margin: EdgeInsets.symmetric(horizontal: _paddingUnit),
                child: PrimaryButton(
                  text: buttonText,
                  height: barHeight,
                  width: constraints.maxWidth * _adjustedButtonWidthRatio,
                  elevation: buttonElevation,
                  onPressed: onPressed,
                ),
              ),
            ]
                .where((widget) => widget != null)
                .toList(), // Remove the null widget
          );
        },
      ),
    );
  }
}
