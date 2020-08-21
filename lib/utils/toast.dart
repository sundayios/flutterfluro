import 'package:aoyanews/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oktoast/oktoast.dart';

void showToast(String msg) {
  Widget widget = Container(
    margin: const EdgeInsets.all(50.0),
    decoration: BoxDecoration(
      color: AppColors.popupBackground,
      borderRadius: AppStyles.popupRadius,
    ),
    padding: AppStyles.popupPadding,
    child: ClipRect(
      child: Text.rich(
        TextSpan(
          children: [
            WidgetSpan(
              child: Padding(
                padding: EdgeInsets.only(bottom: 1, right: 5),
                child: Icon(
                  Icons.info_outline,
                  size: 16,
                  color: AppStyles.popupTextStyle.color,
                ),
              ),
            ),
            TextSpan(text: msg),
          ],
        ),
        style: AppStyles.popupTextStyle,
        textAlign: TextAlign.center,
      ),
    ),
  );

  showToastWidget(widget);
}
