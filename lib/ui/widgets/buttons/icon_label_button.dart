import 'package:flutter/widgets.dart';

/// Signature for when a press or tap has occurred
///
/// This [Callback] allows for a [String] to be passed back if needed
typedef GesturePressCallback = void Function(dynamic info);

/// [IconLabelButton] is a widget that displays an [Icon] on top of a label.
/// This widget can be reused throguhout the app
class IconLabelButton extends StatelessWidget {
  /// The [Icon] to display. Having this be [IconData] makes
  /// the widget more robust, allowing different  types of [Icon]s
  final IconData iconData;

  /// The size of the [Icon]
  final double iconSize;

  /// The size of the [Text] label
  final double fontSize;

  ///The font family to be used
  final String fontFamily;

  /// The [Color] of the [Icon] and [Text] label
  final Color color;

  /// The label to display under the [Icon]
  final String label;

  /// The [String] id so that the callback sends back
  final dynamic callbackId;

  /// The callback for when a press event occurs
  final GesturePressCallback onPressed;

  IconLabelButton({
    @required this.iconData,
    @required this.label,
    @required this.onPressed,
    @required this.callbackId,
    this.iconSize = 36.0,
    this.fontSize = 16.0,
    this.fontFamily = "Roboto",
    this.color = const Color(0xFF000000),
  })  : assert(iconData != null),
        assert(label.isNotEmpty && label != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(callbackId),
      onDoubleTap: () => onPressed(callbackId),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            iconData,
            color: color,
            size: iconSize,
          ),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontFamily: fontFamily,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
