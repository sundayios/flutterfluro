import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 点击空白关闭键盘 && 跳转到其他页面时清除 focus
/// https://flutterigniter.com/dismiss-keyboard-form-lose-focus/
class AutoDismissKeyboard extends StatefulWidget {
  static final routeObserver = RouteObserver<Route>();

  const AutoDismissKeyboard({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _AutoDismissKeyboardState createState() => _AutoDismissKeyboardState();
}

class _AutoDismissKeyboardState extends State<AutoDismissKeyboard>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    AutoDismissKeyboard.routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    AutoDismissKeyboard.routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPushNext() {
    _unFocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unFocus,
      child: widget.child,
    );
  }

  void _unFocus() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}
