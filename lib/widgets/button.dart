import 'package:aoyanews/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum ButtonType {
  NORMAL,
  GHOST,
  ONLY_TEXT,
}

class Button extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final ButtonType type;

  const Button({
    Key key,
    @required this.child,
    @required this.onPressed,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height;
    TextStyle textStyle;
    Color borderColor;
    double radius;
    Gradient gradient;

    if (type == ButtonType.GHOST) {
      height = 36.0;
      textStyle = TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.bold,
      );
      borderColor = Colors.white70;
      radius = height;
    } else if (type == ButtonType.ONLY_TEXT) {
      height = 36.0;
      textStyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
      radius = 4;
    } else {
      height = 36.0;
      textStyle = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      );
      radius = 4;
      gradient = AppStyles.accentGradient;
    }

    final borderRadius = radius == null ? null : BorderRadius.circular(radius);

    Widget w;
    w = FlatButton(
      color: AppColors.transparent,
      shape: borderRadius == null
          ? null
          : RoundedRectangleBorder(borderRadius: borderRadius),
      child: DefaultTextStyle(
        style: textStyle,
        child: child,
      ),
      onPressed: onPressed,
    );
    w = SizedBox(
      child: w,
      height: height,
    );
    w = DecoratedBox(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
        border: borderColor == null
            ? null
            : Border.all(
                color: borderColor,
                width: 1,
              ),
      ),
      child: w,
    );
    return w;
  }
}
