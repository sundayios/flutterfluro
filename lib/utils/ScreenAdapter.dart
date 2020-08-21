import 'dart:ffi';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

class ScreenAdapter {
  static init() {
    // ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    // setDesignWHD(750.0, 1334.0, density: 3);
    ScreenUtil.getInstance();
  }

  static height(double value) {
    return ScreenUtil.getInstance().getHeight(value);
  }

  static width(double value) {
    return ScreenUtil.getInstance().getWidth(value);
  }

  static screenHeight() {
    return ScreenUtil.getInstance().screenHeight;
  }

  static screenWidth() {
    return ScreenUtil.getInstance().screenWidth;
  }

  static adapterSize(double value) {
    return ScreenUtil.getInstance().getAdapterSize(value);
  }

  static getAdapterSize(BuildContext context, double value) {
    return ScreenUtil.getInstance().getAdapterSize(value);
  }

  static screenDensity() {
    return ScreenUtil.getInstance().screenDensity;
  }

// 系统状态栏高度
  static statusBarHeight() {
    return ScreenUtil.getInstance().statusBarHeight;
  }

// BottomBar高度
  static bottomBarHeight() {
    return ScreenUtil.getInstance().bottomBarHeight;
  }

// 系统AppBar高度
  static appBarHeight() {
    return ScreenUtil.getInstance().appBarHeight;
  }

// 根据屏幕宽适配后字体尺寸
  static sp(double value) {
    return ScreenUtil.getInstance().getSp(value);
  }

// 二、依赖context
// 屏幕宽
  static getScreenW(BuildContext context) {
    return ScreenUtil.getScreenW(context);
  }

// 屏幕高
  static getScreenH(BuildContext context) {
    return ScreenUtil.getScreenH(context);
  }

// 屏幕像素密度
  static getScreenDensity(BuildContext context) {
    return ScreenUtil.getScreenDensity(context);
  }

// 系统状态栏高度
  static getStatusBarH(BuildContext context) {
    return ScreenUtil.getStatusBarH(context);
  }

// BottomBar高度
  static getBottomBarH(BuildContext context) {
    return ScreenUtil.getBottomBarH(context);
  }

// 根据屏幕宽适配后尺寸
  static getScaleW(BuildContext context, double value) {
    return ScreenUtil.getScaleW(context, value);
  }

// 根据屏幕高适配后尺寸
  static getScaleH(BuildContext context, double value) {
    return ScreenUtil.getScaleH(context, value);
  }

// 根据屏幕宽适配后字体尺寸
  static getScaleSp(BuildContext context, double value) {
    return ScreenUtil.getScaleSp(context, value);
  }

// 屏幕方向
  static getOrientation(BuildContext context) {
    return ScreenUtil.getOrientation(context);
  }
}

// ScreenAdaper
