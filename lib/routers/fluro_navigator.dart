import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'routers.dart';

/// fluro的路由跳转工具类
class NavigatorUtils {
  static void push(BuildContext context, String path,
      {bool replace = false, bool clearStack = false, Map params}) {
    unfocus();
    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
    print('我是navigateTo传递的参数：$query');

    path = path + query;
    Routes.router.navigateTo(context, path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.native);
  }

  static void pushResult(
      BuildContext context, String path, Function(Object) thenfunction,
      {bool replace = false, bool clearStack = false, Map params}) {
    unfocus();

    String query = "";
    if (params != null) {
      int index = 0;
      for (var key in params.keys) {
        var value = Uri.encodeComponent(params[key]);
        if (index == 0) {
          query = "?";
        } else {
          query = query + "\&";
        }
        query += "$key=$value";
        index++;
      }
    }
    print('我是navigateTo传递的参数：$query');

    Routes.router
        .navigateTo(context, path,
            replace: replace,
            clearStack: clearStack,
            transition: TransitionType.native)
        .then((Object result) {
      // 页面返回result为null
      if (result == null) {
        return;
      }
      thenfunction(result);
    }).catchError((dynamic error) {
      print('$error');
    });
  }

  /// 返回
  static void pop(BuildContext context) {
    unfocus();
    Navigator.pop(context);
  }

  /// 带参数返回
  static void popWithParams(BuildContext context, Object result) {
    unfocus();
    Navigator.pop<Object>(context, result);
  }

  //返回到/根页面：
  static void popToRoot(BuildContext context) {
    unfocus();
    Navigator.of(context).popUntil(ModalRoute.withName('/'));
    // 或Navigator.of(context).popUntil((r) => r.settings.isInitialRoute);
  }

  //返回到路由列表中的某个页面：
  static void popTo(BuildContext context, String routName) {
    unfocus();
    Navigator.of(context).popUntil(ModalRoute.withName(routName));
// 或返回fluro中设定的route：
    // Navigator.of(context).popUntil(ModalRoute.withName(Routes.home));
  }

  /// 跳到WebView页
  static void goWebViewPage(BuildContext context, String title, String url) {
    //fluro 不支持传中文,需转换
    push(context,
        '${Routes.webViewPage}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}');
  }

  static void unfocus() {
    // 使用下面的方式，会触发不必要的build。
    // FocusScope.of(context).unfocus();
    // https://github.com/flutter/flutter/issues/47128#issuecomment-627551073
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
