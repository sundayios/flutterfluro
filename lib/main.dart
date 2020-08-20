import 'dart:async';
import 'package:aoyanews/provider/theme_providerd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:aoyanews/utils/device_uitl.dart';
import 'package:provider/provider.dart';
import 'myapp.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';

// import 'package:easy_localization_loader/easy_localization_loader.dart';
// import 'package:fluro/fluro.dart';

void main() {
  runZoned(() {
    WidgetsFlutterBinding.ensureInitialized();
    // runApp(MyApp());
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeProvider())
        // ChangeNotifierProvider.value(
        //   value: MeNotifier(await sp.getMe()),
        // ),
        // ChangeNotifierProvider.value(
        //   value: AppConfigNotifier(await sp.getAppConfig()),
        // ),
      ],
      child: OKToast(
        child: EasyLocalization(
          child: MyApp(),
          supportedLocales: [
            // Locale('ar', 'DZ'),
            Locale('en', 'US'),
            Locale('zh', 'CN'),
            // Locale('de', 'DE'),
            // Locale('ru', 'RU')
            // Locale('pt', 'PT')
          ],
          path: 'resources/langs',
        ),
      ),
    ));
    // 透明状态栏
    if (Device.isAndroid) {
      final SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }, onError: (obj, stack) {
    print(obj);
    print(stack);
  });
}
