import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:aoyanews/routers/i_router.dart';
import 'package:aoyanews/routers/not_found_page.dart';
import 'package:aoyanews/home/home_page.dart';
import 'package:aoyanews/routers/webview_page.dart';
import 'package:aoyanews/home/home_route.dart';

import 'dart:convert' as convert;

// ignore: avoid_classes_with_only_static_members
class Routes {
  static String home = '/home';
  static String webViewPage = '/webView';

  static final List<IRouterProvider> _listRouter = [];

  static final Router router = Router();

  // 对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配
  // static Future navigateTo(BuildContext context, String path,
  //     {bool replace = false,
  //     bool clearStack = false,
  //     Map<String, dynamic> params,
  //     TransitionType transition = TransitionType.native}) {
  //   String query = "";
  //   if (params != null) {
  //     int index = 0;
  //     for (var key in params.keys) {
  //       var value = Uri.encodeComponent(params[key]);
  //       if (index == 0) {
  //         query = "?";
  //       } else {
  //         query = query + "\&";
  //       }
  //       query += "$key=$value";
  //       index++;
  //     }
  //   }
  //   print('我是navigateTo传递的参数：$query');

  //   path = path + query;
  //   return router.navigateTo(context, path,
  //       replace: replace, clearStack: clearStack, transition: transition);
  // }

  static void initRoutes() {
    /// 指定路由跳转错误返回页
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      debugPrint('未找到目标页');
      return NotFoundPage();
    });

    router.define(home,
        handler: Handler(
            handlerFunc:
                (BuildContext context, Map<String, List<String>> params) =>
                    HomePage()));

    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      final String title = params['title']?.first;
      final String url = params['url']?.first;
      return WebViewPage(title: title, url: url);
    }));

    // UserInfoModel userInfoModel = UserInfoModel('袁致营', 30, 1.78, 74.0);
    // UserInfoModel userInfoModel2 = UserInfoModel('袁致营2', 32, 1.78, 74.0);
    // String jsonString = convert.jsonEncode(userInfoModel);
    // String jsonString2 = convert.jsonEncode(userInfoModel2);

    // Routes.navigateTo(
    //   context,
    //   Routes.wxSharePay,
    //   params: {
    //     'userInfoModel': jsonString,
    //     'userInfoModel2': jsonString2,
    //   },
    // ).then((result) {
    //   // 通过pop回传的值，边缘策划返回则不努力通过此处传值
    // });

    router.define("routePath", handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      // UserInfoModel _model1 = UserInfoModel.fromJson(
      //     convert.jsonDecode(params['userInfoModel'][0]));
      // UserInfoModel _model2 = UserInfoModel.fromJson(
      //     convert.jsonDecode(params['userInfoModel2'][0]));

      // return WxSharePage(
      //   userInfoModel: _model1,
      //   userInfoModel2: _model2,
      // );
      return HomePage();
    }));

    _listRouter.clear();

    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.add(HomeRouter());
    // _listRouter.add(LoginRouter());
    // _listRouter.add(GoodsRouter());
    // _listRouter.add(OrderRouter());
    // _listRouter.add(StoreRouter());
    // _listRouter.add(AccountRouter());
    // _listRouter.add(SettingRouter());
    // _listRouter.add(StatisticsRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
