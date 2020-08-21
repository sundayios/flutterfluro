import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tuple/tuple.dart';
import 'package:aoyanews/pages/home_tab/home_tab.dart';
import 'package:aoyanews/pages/alerts_tab/alerts_tab.dart';
import 'package:aoyanews/pages/live_tab/live_tab.dart';
import 'package:aoyanews/pages/quotes_tab/quotes_tab.dart';
import 'package:aoyanews/pages/mine_tab/mine_tab.dart';
import 'package:aoyanews/style.dart';
import 'package:aoyanews/widgets/logo.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aoyanews/utils/theme_utils.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tabsData = <Tuple3>[
    // Tuple3("assets/ic_logo.svg", '首页', 0),
    // Tuple3("assets/ic_fission.svg", '分裂', 1),
    // Tuple3("assets/ic_pandora.svg", '潘多拉', 2),
    // Tuple3("assets/ic_wallet.svg", '钱包', 3),

    Tuple3(Icons.home, '首页', 0),
    Tuple3(Icons.new_releases, '快讯', 1),
    Tuple3(Icons.live_tv, '直播', 2),
    Tuple3(Icons.format_quote, '行情', 3),
    Tuple3(Icons.more, '我的', 4),
  ];

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<Widget> _tabBodies;
  // ValueNotifier<int> _mainTabIndex = new ValueNotifier(0);
  // PageController _mainTabController;

  @override
  void initState() {
    super.initState();
    // 首页所有 Tab
    _tabBodies = [
      HomeTabPage(),
      AlertsTabPage(),
      LiveTabPage(),
      QutoesTabPage(),
      MineTabPage()
    ];
    // _mainTabController = PageController(
    //   initialPage: _mainTabIndex.value,
    //   keepPage: true,
    // );
  }

  @override
  Widget build(BuildContext context) {
    Widget leading;
    leading = Logo();
    leading = IconButton(
      icon: leading,
      onPressed: () {
        _scaffoldKey.currentState.openDrawer();
      },
    );

    /// 底部导航栏
    Widget _bottomBar(ValueNotifier provider) {
      final items = _tabsData.map((tuple) {
        final selected = provider.value == tuple.item3;
        return BottomNavigationBarItem(
          icon: Icon(
            tuple.item1,
            size: 22,
            color: selected
                ? ThemeUtils.getBottomTabIconColor(context)
                : AppColors.bottom_tabtext_unselcolor,
          ),
          // SvgPicture.asset(
          //   tuple.item1,
          //   width: 22,
          //   height: 22,
          //   color: selected ? null : AppColors.grey,
          // ),
          title: Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Text(
              tuple.item2,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: selected
                    ? ThemeUtils.getTabBarTextColor(context)
                    : AppColors.bottom_tabtext_unselcolor,
              ),
            ),
          ),
        );
      }).toList();

      Widget bottomBar = BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        unselectedFontSize: 12,
        selectedFontSize: 12,
        // elevation: 0,
        items: items,
        currentIndex: provider.value,
        onTap: (int index) {
          // if (index != _mainTabIndex.value) {
          //   setState(() {
          //     _mainTabIndex.value = index;
          //     _mainTabController.jumpToPage(index);
          //   });
          //   return;
          // }
          if (index != provider.value) {
            setState(() {
              provider.value = index;
              // _mainTabController.jumpToPage(index);
            });
            return;
          }
        },
      );
      return bottomBar;
    }

    return ChangeNotifierProvider<ValueNotifier>(
      create: (_) => ValueNotifier(0),
      child: Consumer<ValueNotifier>(builder: (_, provider, __) {
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottomNavigationBar: _bottomBar(provider),
          body: IndexedStack(index: provider.value, children: _tabBodies),
        );
      }),
    );
  }
}
