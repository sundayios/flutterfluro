import 'dart:ui';

// import 'package:flutter_deer/routers/web_page_transitions.dart';
import 'package:aoyanews/route/widget.dart';
import 'package:sp_util/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aoyanews/common/constant.dart';
import 'package:aoyanews/style.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => ['System', 'Light', 'Dark'][index];
}

class ThemeProvider extends ChangeNotifier {
  void syncTheme() {
    final String theme = SpUtil.getString(Constant.theme);
    if (theme.isNotEmpty && theme != ThemeMode.system.value) {
      notifyListeners();
    }
  }

  void setTheme(ThemeMode themeMode) {
    SpUtil.putString(Constant.theme, themeMode.value);
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    final String theme = SpUtil.getString(Constant.theme);
    switch (theme) {
      case 'Dark':
        return ThemeMode.dark;
      case 'Light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  ThemeData getTheme({bool isDarkMode = false}) {
    return ThemeData(
      errorColor: isDarkMode ? AppColors.red_dark : AppColors.red,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: isDarkMode ? AppColors.primary_dark : AppColors.primary,
      accentColor: isDarkMode ? AppColors.accent_dark : AppColors.accent,
      // Tab指示器颜色
      indicatorColor: isDarkMode ? AppColors.app_main_dark : AppColors.app_main,
      // 页面背景色
      scaffoldBackgroundColor:
          isDarkMode ? AppColors.bg_color_dark : Colors.white,
      // 主要用于Material背景色
      canvasColor:
          isDarkMode ? AppColors.bg_material_dark : AppColors.bg_material,
      // 文字选择色（输入框复制粘贴菜单）
      textSelectionColor: AppColors.app_main.withAlpha(70),
      textSelectionHandleColor: AppColors.app_main,
      // textTheme: TextTheme(
      //   // TextField输入文字颜色
      //   subtitle1: isDarkMode ? TextStyles.textDark : TextStyles.text,
      //   // Text文字样式
      //   bodyText1: isDarkMode ? TextStyles.textDark : TextStyles.text,

      //   bodyText2: isDarkMode ? TextStyles.textDark : TextStyles.text,
      //   subtitle2:
      //       isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
      // ),
      // primaryTextTheme: TextTheme(
      //   // TextField输入文字颜色
      //   subtitle1: isDarkMode ? TextStyles.textDark : TextStyles.text,
      //   // Text文字样式
      //   bodyText1: isDarkMode ? TextStyles.textDark : TextStyles.text,

      //   bodyText2: isDarkMode ? TextStyles.textDark : TextStyles.text,
      //   subtitle2:
      //       isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
      // ),
      // inputDecorationTheme: InputDecorationTheme(
      //   hintStyle:
      //       isDarkMode ? TextStyles.textHint14 : TextStyles.textHint14,
      // ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: isDarkMode ? AppColors.bg_color_dark : Colors.white,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      // DividerThemeData(
      //     color: isDarkMode ? AppColors.line_dark : AppColors.line,
      //     space: 0.6,
      //     thickness: 0.6),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      pageTransitionsTheme: _pageTransitionsTheme, //NoTransitionsOnWeb(),
      popupMenuTheme: PopupMenuThemeData(
        elevation: 0,
        color: AppColors.popupBackground,
        textStyle: AppStyles.popupTextStyle,
        shape: const RoundedRectangleBorder(
          borderRadius: AppStyles.popupRadius,
        ),
      ),
    );
  }

  static const _pageTransitionsTheme = PageTransitionsTheme(builders: {
    TargetPlatform.android: AppPageTransitionsBuilder(),
    TargetPlatform.iOS: AppPageTransitionsBuilder(),
  });
}
