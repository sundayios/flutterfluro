import 'package:flutter/material.dart';

import 'route/widget.dart';

/// 颜色
class AppColors {
  AppColors._();
  static const red = Colors.red;
  static const red_dark = Colors.red;

  static const primary = Colors.white;
  static const primary_dark = Colors.black;
  static const accent = Color(0xFFCD0B65);
  static const accent_dark = Color(0xFF4C1C6E);
  static const bg_color_dark = Colors.black;
  static const bg_color = Colors.white;
  static const bg_material_dark = Colors.black;
  static const bg_material = Colors.white;
  static const line_dark = Colors.grey;
  static const line = Colors.grey;
  static const text_gray = Colors.grey;
  static const text_gray_dark = Colors.grey;
  static const text_dark = Colors.grey;
  static const text = Colors.black;
  static const unselected_item_color = Colors.white;

  static const pageBackground = Color(0xFF1A182C);
  static const popupBackground = Color(0xFF20262C);

  static const transparent = Colors.transparent;

  static const bottom_tabtext_unselcolor = text_gray;
  static const bottom_tabtext_main = Colors.black;
  static const bottom_tabtext_main_dark = Colors.white;
  static const app_main_dark = Colors.orange;
  static const app_main = Colors.orange;
}

/// 尺寸
class AppDimensions {
  AppDimensions._();

  static const double font_sp10 = 10.0;
  static const double font_sp12 = 12.0;
  static const double font_sp14 = 14.0;
  static const double font_sp15 = 15.0;
  static const double font_sp16 = 16.0;
  static const double font_sp18 = 18.0;

  static const double gap_dp4 = 4;
  static const double gap_dp5 = 5;
  static const double gap_dp8 = 8;
  static const double gap_dp10 = 10;
  static const double gap_dp12 = 12;
  static const double gap_dp15 = 15;
  static const double gap_dp16 = 16;
  static const double gap_dp24 = 24;
  static const double gap_dp32 = 32;
  static const double gap_dp50 = 50;

  static const double iconSize = 16;
  static const double iconSizeLarge = 20;
  static const double popupRadius = 10;
  static const double pad = 16;
  static const double lagerPad = 32;
}

// 风格
class AppStyles {
  AppStyles._();

  static const popupTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
  static const popupRadius =
      BorderRadius.all(Radius.circular(AppDimensions.popupRadius));
  static const popupPadding =
      EdgeInsets.symmetric(horizontal: 10, vertical: 10);

  static const accentGradient = LinearGradient(
    colors: [AppColors.accent_dark, AppColors.accent],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );
  static const accentGradientReversed = LinearGradient(
    colors: [AppColors.accent, AppColors.accent_dark],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );
}

class TextStyles {
  TextStyles._();
  static const TextStyle textSize12 = TextStyle(
      fontSize: AppDimensions.font_sp12, decoration: TextDecoration.none);
  static const TextStyle textSize16 = TextStyle(
      fontSize: AppDimensions.font_sp16, decoration: TextDecoration.none);
  static const TextStyle textBold14 = TextStyle(
      fontSize: AppDimensions.font_sp14,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none);
  static const TextStyle textBold16 = TextStyle(
      fontSize: AppDimensions.font_sp16,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none);
  static const TextStyle textBold18 = TextStyle(
      fontSize: AppDimensions.font_sp18,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none);
  static const TextStyle textBold24 = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none);
  static const TextStyle textBold26 = TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.none);

  static const TextStyle textGray14 = TextStyle(
      fontSize: AppDimensions.font_sp14,
      color: AppColors.text_gray,
      decoration: TextDecoration.none);
  static const TextStyle textDarkGray14 = TextStyle(
      fontSize: AppDimensions.font_sp14,
      color: AppColors.text_gray,
      decoration: TextDecoration.none);

  static const TextStyle textWhite14 = TextStyle(
      fontSize: AppDimensions.font_sp14,
      color: Colors.white,
      decoration: TextDecoration.none);

  static const TextStyle text = TextStyle(
      fontSize: AppDimensions.font_sp14,
      color: AppColors.text,
      // https://github.com/flutter/flutter/issues/40248
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none);
  static const TextStyle textDark = TextStyle(
      fontSize: AppDimensions.font_sp14,
      color: AppColors.text_dark,
      textBaseline: TextBaseline.alphabetic,
      decoration: TextDecoration.none);

  static const TextStyle textGray12 = TextStyle(
      fontSize: AppDimensions.font_sp12,
      color: AppColors.text_gray,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none);
  static const TextStyle textDarkGray12 = TextStyle(
      fontSize: AppDimensions.font_sp12,
      color: AppColors.text_gray_dark,
      fontWeight: FontWeight.normal,
      decoration: TextDecoration.none);

  static const TextStyle textHint14 = TextStyle(
      fontSize: AppDimensions.font_sp14,
      color: AppColors.unselected_item_color,
      decoration: TextDecoration.none);
}

/// 主题
// class AppThemes {
//   AppThemes._();

//   static final defaultTheme = ThemeData(
//     brightness: Brightness.dark,
//     primaryColor: AppColors.primary,
//     // CircleAvatar 里的背景受这个影响
//     primaryColorDark: Colors.transparent,
//     accentColor: AppColors.accent,
//     backgroundColor: AppColors.pageBackground,
//     scaffoldBackgroundColor: AppColors.pageBackground,
//     buttonColor: AppColors.accent,
//     fontFamily: "Ubuntu",
//     pageTransitionsTheme: _pageTransitionsTheme,
//     dividerTheme: DividerThemeData(space: 0),
//     popupMenuTheme: PopupMenuThemeData(
//       elevation: 0,
//       color: AppColors.popupBackground,
//       textStyle: AppStyles.popupTextStyle,
//       shape: const RoundedRectangleBorder(
//         borderRadius: AppStyles.popupRadius,
//       ),
//     ),
//   );

//   static const _pageTransitionsTheme = PageTransitionsTheme(builders: {
//     TargetPlatform.android: AppPageTransitionsBuilder(),
//     TargetPlatform.iOS: AppPageTransitionsBuilder(),
//   });
// }
