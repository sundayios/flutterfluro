import 'package:fluro/fluro.dart';
import 'package:aoyanews/routers/i_router.dart';
import 'package:aoyanews/home/home_page.dart';

class HomeRouter implements IRouterProvider {
  static String homePage = '/home';

  @override
  void initRouter(Router router) {
    router.define(homePage,
        handler: Handler(handlerFunc: (_, __) => HomePage()));
  }
}
