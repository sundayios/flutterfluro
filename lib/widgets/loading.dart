import 'package:aoyanews/style.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  final double size;
  final Color beginColor;
  final Color endColor;

  const LoadingIndicator({Key key, this.size, this.beginColor, this.endColor})
      : super(key: key);

  @override
  _LoadingIndicatorState createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.repeat(period: Duration(milliseconds: 500), reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tween = ColorTween(
        begin: widget.beginColor ?? AppColors.accent,
        end: widget.endColor ?? AppColors.accent_dark);
    return SizedBox(
      width: widget.size ?? 20,
      height: widget.size ?? 20,
      child: CircularProgressIndicator(
        valueColor: _controller.drive(tween),
      ),
    );
  }
}

void showGlobalLoading(BuildContext context, {String title}) {
  showDialog<Null>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return _MyGlobalLoading(
        title: title == null ? null : Text(title),
      );
    },
  );
}

void hideGlobalLoading(BuildContext context) {
  Navigator.pop(context);
}

class _MyGlobalLoading extends Dialog {
  final Widget title;

  const _MyGlobalLoading({
    Key key,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget w;
    if (title != null) {
      w = Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 14.0,
            color: const Color(0xff333333),
          ),
          child: title,
        ),
      );
    }

    w = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const LoadingIndicator(),
        ...(title == null ? [] : [SizedBox(height: 16), w]),
      ],
    );

    w = Container(
      constraints: BoxConstraints.loose(Size(200, 200)),
      padding: EdgeInsets.all(24),
      decoration: const ShapeDecoration(
        color: AppColors.popupBackground,
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(20),
          ),
        ),
      ),
      child: w,
    );

    w = Material(
      type: MaterialType.transparency,
      child: Center(
        child: w,
      ),
    );

    return w;
  }
}
