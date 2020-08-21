import 'dart:async';

import 'package:flutter/widgets.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  Animation _transitionAnimation;
  AnimationStatusListener _transitionListener;
  bool _needSetState = false;

  /// 页面是否正在切换
  final ValueNotifier isInTransition = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _transitionListener = (status) {
      isInTransition.value = status == AnimationStatus.forward ||
          status == AnimationStatus.reverse;
    };
    isInTransition.addListener(() {
      if (isInTransition.value) {
        return;
      }
      // 切换动画结束毫秒后，检查是否需要 setState
      Future.microtask(() {
        if (!mounted || !_needSetState) {
          return;
        }
        super.setState(() {});
      });
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _transitionAnimation?.removeStatusListener(_transitionListener);
    _transitionAnimation = ModalRoute.of(context).animation;
    _transitionAnimation?.addStatusListener(_transitionListener);
  }

  @mustCallSuper
  @override
  void dispose() {
    _transitionAnimation?.removeStatusListener(_transitionListener);
    isInTransition.dispose();
    super.dispose();
  }

  /// 在页面切换时会延迟 setState
  @override
  void setState(fn) {
    if (!isInTransition.value) {
      super.setState(fn);
      _needSetState = false;
      return;
    }
    fn();
    _needSetState = true;
  }
}
