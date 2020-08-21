import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:aoyanews/routers/route_obsever.dart';

class WebViewPage extends StatefulWidget {
  static final routeObserver = WebViewRouteObserver();
  const WebViewPage({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);

  final String title;
  final String url;

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (context, snapshot) {
          return WillPopScope(
              onWillPop: () async {
                if (snapshot.hasData) {
                  bool canGoBack = await snapshot.data.canGoBack();
                  if (canGoBack) {
                    // 网页可以返回时，优先返回上一页
                    await snapshot.data.goBack();
                    return Future.value(false);
                  }
                }
                return Future.value(true);
              },
              child: Scaffold(
                resizeToAvoidBottomPadding: false,
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  leading: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  elevation: 0,
                  backgroundColor: Theme.of(context).accentColor,
                  title: Text('Basic AppBar'),
                  actions: <Widget>[
                    new IconButton(
                      // action button
                      icon: new Icon(Icons.fast_forward),
                      onPressed: () {},
                    ),
                  ],
                ),
                body: WebView(
                  initialUrl: widget.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.complete(webViewController);
                  },
                ),
              ));
        });
  }
}
