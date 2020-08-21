import 'package:aoyanews/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double size;

  const Logo({Key key, double size})
      : this.size = size ?? 32,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget w;
    w = SvgPicture.asset(
      "assets/ic_logo.svg",
      width: size * 1.2,
      height: size * 1.2,
    );
    w = OverflowBox(
      maxWidth: double.infinity,
      maxHeight: double.infinity,
      alignment: Alignment.center,
      child: w,
    );
    w = ClipOval(
      child: w,
    );
    w = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF602650), AppColors.primary],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(size),
      ),
      child: Center(child: w),
    );
    return w;
  }
}
