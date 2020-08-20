import 'package:aoyanews/utils/keyboard_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter/cupertino.dart';
import 'cupertino_route.dart';

/// 自定义 route
class AppRoute<T> extends MaterialPageRoute<T> {
  final bool enablePushTransition;
  final bool enablePopTransition;

  AppRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
    this.enablePushTransition = true,
    this.enablePopTransition = true,
  })  : assert(builder != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        assert(opaque),
        super(
          // 自动关闭软键盘
          builder: (ctx) => AutoDismissKeyboard(child: builder(ctx)),
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );

  @optionalTypeArgs
  static AppRoute<T> of<T extends Object>(BuildContext context) =>
      ModalRoute.of(context);

  T _result;

  /// 设置默认返回值
  void setResult(T result) {
    _result = result;
  }

  @protected
  @override
  void didComplete(T result) {
    super.didComplete(result ?? _result);
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return super.buildTransitions(
        context,
        enablePushTransition != false ? animation : AlwaysStoppedAnimation(1.0),
        enablePopTransition != false
            ? secondaryAnimation
            : AlwaysStoppedAnimation(0.0),
        child);
  }
}

/// 自定义 page 变换动画
class AppPageTransitionsBuilder extends PageTransitionsBuilder {
  const AppPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return CupertinoPageRoute.buildPageTransitions<T>(
        route, context, animation, secondaryAnimation, child);
  }
}
