import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'dart:async';

class PictureProvider {
  static const String imgSizeStrFromUrlRegStr = r"(?<=sinaimg.cn\/)\w+";

  ///根据图片Url返回图片Provider
  static ImageProvider getPictureFromUrl(String url, {String imgSize}) {
    if (url == null || url.contains('default') || url.contains('null')) {
      return ExtendedAssetImageProvider('assets/images/white.jpg');
    }
    if (imgSize != null) {
      url = url.replaceFirst(RegExp(imgSizeStrFromUrlRegStr), imgSize);
    }
    CachedNetworkImageProvider returnImageProvider;
    try {
      returnImageProvider = CachedNetworkImageProvider(url);
    } catch (e) {
      print(e);
    }

    return returnImageProvider;
  }
}
