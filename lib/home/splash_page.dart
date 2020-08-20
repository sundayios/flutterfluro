import 'dart:async';

import 'package:flutter/material.dart';
import 'package:aoyanews/common/constant.dart';
import 'package:aoyanews/home/home_route.dart';
import 'package:aoyanews/routers/fluro_navigator.dart';
import 'package:aoyanews/utils/image_utils.dart';
import 'package:aoyanews/utils/theme_utils.dart';
import 'package:aoyanews/widgets/load_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:sp_util/sp_util.dart';
import 'package:connectivity/connectivity.dart';
import 'package:aoyanews/common/enum_global.dart';

import 'package:provider/provider.dart';
import 'package:aoyanews/provider/theme_providerd.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  NetWorkState _status = NetWorkState.normal;
  final List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      /// 两种初始化方案，另一种见 main.dart
      /// 两种方法各有优劣
      await SpUtil.getInstance();
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        /// 预先缓存图片，避免直接使用时因为首次加载造成闪动
        _guideList.forEach((image) {
          precacheImage(
              ImageUtils.getAssetImage(image, format: ImageFormat.webp),
              context);
        });
      }
      _initSplash();
      // Future.microtask(_tryPush);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _initGuide() {
    setState(() {
      _status = NetWorkState.normal;
    });
  }

  void _initSplash() {
    _subscription =
        Stream.value(1).delay(Duration(milliseconds: 1500)).listen((_) {
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        SpUtil.putBool(Constant.keyGuide, false);
        _initGuide();
      } else {
        _goHome();
      }
    });
  }

  void _goHome() {
    NavigatorUtils.push(context, HomeRouter.homePage, replace: true);
  }

  Future<bool> _hasNetwork() async {
    return (await Connectivity().checkConnectivity()) !=
        ConnectivityResult.none;
  }

  // Future _tryPush() async {
  //   final appConfigNotifier = Provider.of<AppConfigNotifier>(
  //     context,
  //     listen: false,
  //   );
  //   final meNotifier = Provider.of<MeNotifier>(
  //     context,
  //     listen: false,
  //   );

  //   AppConfig appConfig = appConfigNotifier.value;
  //   if (appConfig == null) {
  //     setState(() {
  //       _state = _State.loading;
  //     });

  //     if (!(await _hasNetwork())) {
  //       setState(() {
  //         _state = _State.noNetwork;
  //       });

  //       // 等待到有网络为止
  //       while (!(await _hasNetwork())) {
  //         await Future.delayed(Duration(milliseconds: 500));
  //       }
  //     }

  //     setState(() {
  //       _state = NetWorkState.loading;
  //     });

  //     appConfig = (await G.get().api.getAppConfig()).getDataOrShowErr();
  //     if (appConfig == null) {
  //       return;
  //     }
  //     appConfigNotifier.value = appConfig;
  //   }

  //   final me = meNotifier.value;
  //   if (me == null) {
  //     Router.pushLoginOrRegister(context,
  //         removeUtil: true, enablePushTransition: false);
  //     return;
  //   }
  //   Router.pushHomepage(context, removeUtil: true, enablePushTransition: false);
  // }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);

    return Material(
        color: ThemeUtils.getBackgroundColor(context),
        child: _status == NetWorkState.noNetwork
            ? FractionallyAlignedSizedBox(
                heightFactor: 0.3,
                widthFactor: 0.33,
                leftFactor: 0.33,
                bottomFactor: 0,
                child: const LoadAssetImage('logo'))
            : Swiper(
                key: const Key('swiper'),
                itemCount: _guideList.length,
                loop: false,
                itemBuilder: (_, index) {
                  return LoadAssetImage(
                    _guideList[index],
                    key: Key(_guideList[index]),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    format: ImageFormat.webp,
                  );
                },
                onTap: (index) {
                  if (index == _guideList.length - 1) {
                    _goHome();
                  }
                },
              ));
  }
}
