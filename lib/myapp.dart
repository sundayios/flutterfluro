import 'dart:async';
import 'package:aoyanews/provider/theme_providerd.dart';
import 'package:aoyanews/utils/theme_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:aoyanews/provider/theme_providerd.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:aoyanews/routers/routers.dart';
import 'package:aoyanews/routers/not_found_page.dart';
import 'package:flustars/flustars.dart';
import 'package:aoyanews/home/splash_page.dart';

import 'package:oktoast/oktoast.dart';

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _initAsync();
    setDesignWHD(360.0, 640.0, density: 3);
    Routes.initRoutes();
    super.initState();
  }

  void _initAsync() async {
    await SpUtil.getInstance();
  }

//   @override
//   Widget build(BuildContext context) {
//     return OKToast(
//         child: Consumer<ThemeProvider>(
//           builder: (_, provider, __) {
//             return MaterialApp(
//               title: 'Flutter Deer',
// //              showPerformanceOverlay: true, //显示性能标签
// //              debugShowCheckedModeBanner: false, // 去除右上角debug的标签
// //              checkerboardRasterCacheImages: true,
// //              showSemanticsDebugger: true, // 显示语义视图
// //              checkerboardOffscreenLayers: true, // 检查离屏渲染
//               theme: provider.getTheme(),
//               darkTheme: provider.getTheme(isDarkMode: true),
//               themeMode: provider.getThemeMode(),
//               home: SplashPage(),
//               onGenerateRoute: Routes.router.generator,
//               localizationsDelegates: const [
//                 GlobalMaterialLocalizations.delegate,
//                 GlobalWidgetsLocalizations.delegate,
//                 GlobalCupertinoLocalizations.delegate,
//               ],
//               supportedLocales: const <Locale>[
//                 Locale('zh', 'CN'),
//                 Locale('en', 'US')
//               ],
//               builder: (context, child) {
//                 /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
//                 return MediaQuery(
//                   data: MediaQuery.of(context).copyWith(
//                       textScaleFactor:
//                           1.0), // 或者 MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor: 1.0),
//                   child: child,
//                 );
//               },

//               /// 因为使用了fluro，这里设置主要针对Web
//               onUnknownRoute: (_) {
//                 return MaterialPageRoute(
//                   builder: (BuildContext context) => NotFoundPage(),
//                 );
//               },
//             );
//           },
//         ),

//         /// Toast 配置
//         backgroundColor: Colors.black54,
//         textPadding:
//             const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
//         radius: 20.0,
//         position: ToastPosition.bottom);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return OKToast(
//         child: ChangeNotifierProvider<ThemeProvider>(
//           create: (_) => ThemeProvider(),
//           child: Consumer<ThemeProvider>(
//             builder: (_, provider, __) {
//               return MaterialApp(
//                 title: 'Flutter Deer',
// //              showPerformanceOverlay: true, //显示性能标签
// //              debugShowCheckedModeBanner: false, // 去除右上角debug的标签
// //              checkerboardRasterCacheImages: true,
// //              showSemanticsDebugger: true, // 显示语义视图
// //              checkerboardOffscreenLayers: true, // 检查离屏渲染
//                 theme: provider.getTheme(),
//                 darkTheme: provider.getTheme(isDarkMode: true),
//                 themeMode: provider.getThemeMode(),
//                 home: SplashPage(),
//                 onGenerateRoute: Routes.router.generator,
//                 localizationsDelegates: const [
//                   GlobalMaterialLocalizations.delegate,
//                   GlobalWidgetsLocalizations.delegate,
//                   GlobalCupertinoLocalizations.delegate,
//                 ],
//                 supportedLocales: const <Locale>[
//                   Locale('zh', 'CN'),
//                   Locale('en', 'US')
//                 ],
//                 builder: (context, child) {
//                   /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
//                   return MediaQuery(
//                     data: MediaQuery.of(context).copyWith(
//                         textScaleFactor:
//                             1.0), // 或者 MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor: 1.0),
//                     child: child,
//                   );
//                 },

//                 /// 因为使用了fluro，这里设置主要针对Web
//                 onUnknownRoute: (_) {
//                   return MaterialPageRoute(
//                     builder: (BuildContext context) => NotFoundPage(),
//                   );
//                 },
//               );
//             },
//           ),
//         ),

//         /// Toast 配置
//         backgroundColor: Colors.black54,
//         textPadding:
//             const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
//         radius: 20.0,
//         position: ToastPosition.bottom);
//   }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    // provider.setTheme(ThemeMode.dark);
    // context.read<ThemeProvider>().getTheme()
    return Container(
      child: MaterialApp(
        title: '澳亚财经',
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          EasyLocalization.of(context).delegate,
        ],
        supportedLocales: EasyLocalization.of(context).supportedLocales,
        locale: EasyLocalization.of(context).locale,
        debugShowCheckedModeBanner: false,
        theme: provider.getTheme(),
        darkTheme: provider.getTheme(isDarkMode: true),
        themeMode: provider.getThemeMode(),
        onGenerateRoute: Routes.router.generator,
        home: SplashPage(),
        builder: (context, child) {
          /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                textScaleFactor:
                    1.0), // 或者 MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor: 1.0),
            child: child,
          );
        },
        onUnknownRoute: (_) {
          return MaterialPageRoute(
            builder: (BuildContext context) => NotFoundPage(),
          );
        },
        // initialRoute: '/',

        // routes: {
        // '/':(context) => IndexPage(),
        // '/registerloginpage': (context) => Register_Login_Page(),
        // '/loginActionPage': (context) => LoginActionPage(),
        // '/registeraccount': (context) => RegisterAccount(),
        // '/verify_code_page': (context,{arguments}) => VerifyCodePage(arguments:arguments),
        // '/forget_pwd': (context) => ForgetPassworld(),
        // },
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   final Widget home;
//   final ThemeData theme;

//   MyApp({this.home, this.theme}) {
//     // Log.init();
//     // initDio();
//     // Routes.initRoutes();
//   }

// @override
// Widget build(BuildContext context) {
//   return OKToast(
//     child: ChangeNotifierProvider<ThemeProvider>(
//       create: (_) => ThemeProvider(),
//       child: Consumer(builder: (_, provider, __) {
//         return MaterialApp(
//           title: '',
//           theme: theme ?? provider.getTheme(),
//           darkTheme: provider.getTheme(isDarkMode: true),
//           themeMode: provider.getThemeMode(),
//           home: home ?? MyHomePage(),
//           // onGenerateRoute: Routes.router.generator,
//           localizationsDelegates: const [
//             // AppLocalizationsDelegate(),
//             GlobalMaterialLocalizations.delegate,
//             GlobalWidgetsLocalizations.delegate,
//             GlobalCupertinoLocalizations.delegate,
//           ],
//           supportedLocales: const <Locale>[
//             Locale('zh', 'CN'),
//             Locale('en', 'US')
//           ],
//           // path: 'resources.langs',
//           builder: (context, child) {
//             /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
//             return MediaQuery(
//               data: MediaQuery.of(context).copyWith(
//                   textScaleFactor:
//                       1.0), // 或者 MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor: 1.0),
//               child: child,
//             );
//           },

//           /// 因为使用了fluro，这里设置主要针对Web
//           onUnknownRoute: (_) {
//             return MaterialPageRoute(
//                 builder: (BuildContext context) =>
//                     Text('data') //NotFoundage(),
//                 );
//           },
//         );
//       }),
//     ),
//   );
// }
// }
