import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeTabPage extends StatefulWidget {
  HomeTabPage({Key key}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage>
    with TickerProviderStateMixin {
  final _tabIndex = ValueNotifier(0);
  TabController _tabCtrl;
  @override
  bool get wantKeepAlive => true;

  // final _tabIndex = ValueNotifier(0);
  // TabController _tabCtrl;
  final tabTitles = [
    "关注",
    "动态",
    "政策",
    "直播",
    "微社区",
    "视频",
    "一线",
    "DeFi",
    "矿业",
    "IPFS",
    "课程",
    "专题",
    "公告",
    "技术",
    "产业",
    "深度"
  ];

  @override
  void initState() {
    super.initState();

    _tabCtrl = TabController(
      vsync: this,
      length: tabTitles.length,
      initialIndex: _tabIndex.value,
    )..addListener(() {
        // 监听 & 记录 index
        if (_tabCtrl.indexIsChanging) {
          return;
        }
        _tabIndex.value = _tabCtrl.index;
      });

    super.initState();
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  Widget _tabBar() {
    List<Widget> tabsTitles = tabTitles
        .map((val) => Text(val,
                style: TextStyle(
                    fontSize: 14,
                    color:
                        Colors.black) //Theme.of(context).textTheme.subtitle1,
                )
            // Tab(
            //       text: val, //.tr(),
            //     )
            )
        .toList();
    return TabBar(
      indicatorWeight: 3,
      controller: this._tabCtrl,
      isScrollable: true,
      tabs: tabsTitles,
    );
  }

  List<Widget> tabBodies() {
    return tabTitles
        .map((val) => Text(val,
            style: TextStyle(
                fontSize: 14,
                color: Colors.black) //Theme.of(context).textTheme.subtitle1,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[],
                )),
            _tabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabCtrl,
                children: tabBodies(),
              ),
            ),
          ]),
    ));
  }
}
