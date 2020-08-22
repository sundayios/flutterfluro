import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:cookiej/cookiej/provider/picture_provider.dart';
import 'package:aoyanews/utils/image_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:easy_localization/easy_localization.dart';

class MineTabPage extends StatefulWidget {
  MineTabPage({Key key}) : super(key: key);

  @override
  _MineTabPageState createState() => _MineTabPageState();
}

class _MineTabPageState extends State<MineTabPage> {
  RefreshController _controller = RefreshController();

  @override
  Widget build(BuildContext context) {
    final tsfirst = Theme.of(context).textTheme.headline6;
    final tsfirst_gray =
        Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.grey);
    return RefreshConfiguration.copyAncestor(
        context: context,
        enableBallisticLoad: false,
        footerTriggerDistance: -80,
        child: SmartRefresher(
          controller: _controller,
          enablePullUp: true,
          // header: GifHeader1(),
          onRefresh: () async {
            await Future.delayed(Duration(milliseconds: 2000));
            _controller.refreshCompleted();
          },
          onLoading: () async {
            await Future.delayed(Duration(milliseconds: 2000));
            _controller.loadFailed();
          },
          child: Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.grey.withAlpha(4),
            // appBar: AppBar(
            //   bottom: PreferredSize(
            //       child: Expanded(
            //         flex: 4,
            //         child: Column(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: <Widget>[

            //             ]),
            //       ),
            //       preferredSize: Size.fromHeight(128)),
            //   title: Text('Basic AppBar'),
            //   actions: <Widget>[
            //     new IconButton(
            //       // action button
            //       icon: new Icon(Icons.fast_forward),
            //       onPressed: () {},
            //     ),
            //   ],
            // ),
            body: Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                // physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {},
                            child: Hero(
                              tag: "iconUrl",
                              child: SizedBox(
                                child: ClipOval(
                                  child: Image(
                                    image:
                                        ImageUtils.getImageProvider("imageUrl"),
                                  ),
                                ),
                                width: 64,
                                height: 64,
                              ),
                            )),
                        Expanded(
                          child: ListTile(
                            title: RichText(
                                text: TextSpan(
                                    text: "点击登录".tr(),
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 14,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {})),
                            trailing: RichText(
                                text: TextSpan(
                                    text: "邀请好友".tr(),
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 14,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {})),
                          ),
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(left: 14, bottom: 10),
                  ),
                  Divider(
                    indent: 15,
                    endIndent: 15,
                    thickness: 0,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 14, bottom: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FlatButton(
                                onPressed: () {},
                                child: Column(children: [
                                  Text("0".tr(), style: tsfirst),
                                  Text("金币".tr(), style: tsfirst_gray)
                                ])),
                            FlatButton(
                                onPressed: () {},
                                child: Column(children: [
                                  Text("0".tr(), style: tsfirst),
                                  Text("关注".tr(), style: tsfirst_gray)
                                ])),
                            FlatButton(
                                onPressed: () {},
                                child: Column(children: [
                                  Text("0".tr(), style: tsfirst),
                                  Text("粉丝".tr(), style: tsfirst_gray)
                                ])),
                            FlatButton(
                                onPressed: () {},
                                child: Column(children: [
                                  Text("0".tr(), style: tsfirst),
                                  Text("消息".tr(), style: tsfirst_gray)
                                ])),
                          ])),
                  Text('overline  10  normal  gray',
                      style: Theme.of(context).textTheme.overline),
                  Divider(),
                  Text('subtitle  14  medium  black',
                      style: Theme.of(context).textTheme.subtitle),
                  Text('subtitle2 14  medium  black',
                      style: Theme.of(context).textTheme.subtitle2),
                  Text('button  14  medium  black',
                      style: Theme.of(context).textTheme.button),
                  Divider(),
                  Text('caption 12  normal  grey',
                      style: Theme.of(context).textTheme.caption),
                  Divider(),
                  Text('body1 14  normal  black',
                      style: Theme.of(context).textTheme.body1),
                  Text('bodyText2 14  normal  black',
                      style: Theme.of(context).textTheme.bodyText2),
                  Divider(),
                  Text('body2 14  medium  black',
                      style: Theme.of(context).textTheme.body2),
                  Text('bodyText1 14  medium  black',
                      style: Theme.of(context).textTheme.bodyText1),
                  Divider(),
                  Text('subhead 16  normal  black',
                      style: Theme.of(context).textTheme.subhead),
                  Text('subtitle1 16  normal  black',
                      style: Theme.of(context).textTheme.subtitle1),
                  Divider(),
                  Text('title 20  medium  black',
                      style: Theme.of(context).textTheme.title),
                  Text('headline6 20  medium  black',
                      style: Theme.of(context).textTheme.headline6),
                  Divider(),
                  Text('headline  24  normal  black',
                      style: Theme.of(context).textTheme.headline),
                  Text('headline5 24  normal  black',
                      style: Theme.of(context).textTheme.headline5),
                  Divider(),
                  Text('display1 34  normal  grey',
                      style: Theme.of(context).textTheme.display1),
                  Text('headline4 34  normal  grey',
                      style: Theme.of(context).textTheme.headline4),
                  Divider(),
                  Text('display2 45  normal  grey',
                      style: Theme.of(context).textTheme.display2),
                  Text('headline3 45  normal  grey',
                      style: Theme.of(context).textTheme.headline3),
                  Divider(),
                  Text('display3 56  normal  grey',
                      style: Theme.of(context).textTheme.display3),
                  Text('headline2 56  normal  grey',
                      style: Theme.of(context).textTheme.headline2),
                  Divider(),
                  Text('display4 112  thin  grey',
                      style: Theme.of(context).textTheme.display4),
                  Text('headline1 112  thin  grey',
                      style: Theme.of(context).textTheme.headline1),
                ],
              ),
            ),
          ),
        ));
  }
}
