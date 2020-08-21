import 'dart:async';

import 'package:aoyanews/base/state.dart';
import 'package:aoyanews/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:aoyanews/style.dart';
import 'package:aoyanews/utils/toast.dart';
import 'package:aoyanews/widgets/loading.dart';

import 'cupertino_refresh.dart';

typedef Future<List<T>> PageFuture<T>(int pageIndex);
typedef Future RefreshFuture();
typedef Widget ItemBuilder<T>(BuildContext context, T entry, int index);

class RefreshController<T> {
  final List<T> _items;
  final bool _usePrimary;
  ScrollController _scrollController;

  final _itemChangeNotifier = ChangeNotifier();
  final _refreshNotifier = ChangeNotifier();

  RefreshController({bool usePrimaryScrollController = true, Iterable<T> items})
      : _items = items?.toList() ?? [],
        _usePrimary = usePrimaryScrollController ?? true,
        _scrollController =
            (usePrimaryScrollController ?? true) ? null : ScrollController();

  void refresh() {
    _scrollController?.jumpTo(0);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    _refreshNotifier.notifyListeners();
  }

  void updateItems(bool func(List<T> items)) {
    final changed = func(_items);
    if (changed) {
      // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
      _itemChangeNotifier.notifyListeners();
    }
  }

  void jumpToTop() {
    _scrollController?.jumpTo(0.0);
  }

  void dispose() {
    if (!_usePrimary) {
      _scrollController?.dispose();
    }
    _itemChangeNotifier.dispose();
  }

  void _didChangeDependencies(BuildContext context) {
    if (_usePrimary) {
      _scrollController = PrimaryScrollController.of(context);
    }
  }
}

class Refresh<T> extends StatefulWidget {
  /// 分页列表
  const Refresh.pagination({
    Key key,
    @required this.controller,
    this.pageSize = 20, //API.PAGE_SIZE,
    @required this.pageFuture,
    @required this.itemBuilder,
    this.separatorBuilder,
    this.initialRefresh = true,
    this.header,
    this.refreshIndicatorBackgroundColor,
    this.refreshIndicatorColor,
  })  : assert(controller != null),
        assert(pageSize != null),
        assert(pageFuture != null),
        assert(itemBuilder != null),
        this.refreshFuture = null,
        this.children = null,
        this.gridDelegate = null,
        super(key: key);

  /// 固定列表
  const Refresh.fixed({
    Key key,
    @required this.controller,
    @required this.refreshFuture,
    @required this.children,
    this.initialRefresh = true,
    this.header,
    this.refreshIndicatorBackgroundColor,
    this.refreshIndicatorColor,
  })  : assert(controller != null),
        assert(refreshFuture != null),
        assert(children != null),
        this.pageSize = null,
        this.pageFuture = null,
        this.itemBuilder = null,
        this.gridDelegate = null,
        this.separatorBuilder = null,
        super(key: key);

  /// 分页表格
  const Refresh.paginationGrid({
    Key key,
    @required this.controller,
    this.pageSize = 20,
    @required this.pageFuture,
    @required this.itemBuilder,
    @required this.gridDelegate,
    this.initialRefresh = true,
    this.header,
    this.refreshIndicatorBackgroundColor,
    this.refreshIndicatorColor,
  })  : assert(controller != null),
        assert(pageFuture != null),
        assert(itemBuilder != null),
        this.refreshFuture = null,
        this.children = null,
        this.separatorBuilder = null,
        super(key: key);

  final RefreshController<T> controller;
  final int pageSize;
  final PageFuture<T> pageFuture;
  final ItemBuilder<T> itemBuilder;

  // 固定列表
  final RefreshFuture refreshFuture;
  final List<Widget> children;

  // 表格
  final SliverGridDelegate gridDelegate;

  final IndexedWidgetBuilder separatorBuilder;

  /// 是否在初始化的时候触发一次刷新
  final bool initialRefresh;

  final Widget header;

  final Color refreshIndicatorBackgroundColor;
  final Color refreshIndicatorColor;

  @override
  _RefreshState<T> createState() => _RefreshState<T>();
}

class _RefreshState<T> extends BaseState<Refresh> {
  VoidCallback _itemChangedListener;
  VoidCallback _refreshListener;
  int _pageIndex; // 从 1 开始
  ValueNotifier<bool> _loadingMore;
  bool _noMoreData;
  bool _refreshing;

  @override
  void initState() {
    super.initState();
    _pageIndex = -1; // -1 表示第一次加载
    _loadingMore = ValueNotifier<bool>(false);
    _noMoreData = true;
    _refreshing = false;

    _itemChangedListener = () {
      if (mounted) {
        setState(() {});
      }
    };
    widget.controller._itemChangeNotifier.addListener(_itemChangedListener);

    _refreshListener = () async {
      if (mounted) {
        setState(() {
          _refreshing = true;
        });
      }

      // 触发刷新
      await _onRefresh();

      if (mounted) {
        setState(() {
          _refreshing = false;
        });
      }
    };
    widget.controller._refreshNotifier.addListener(_refreshListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.controller._didChangeDependencies(context);
  }

  @override
  void didUpdateWidget(Refresh oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?._itemChangeNotifier
          ?.removeListener(_itemChangedListener);
      oldWidget.controller?._refreshNotifier?.removeListener(_refreshListener);
      widget.controller?._itemChangeNotifier?.addListener(_itemChangedListener);
      widget.controller?._refreshNotifier?.addListener(_refreshListener);
    }
  }

  @override
  void dispose() {
    widget.controller._refreshNotifier.removeListener(_refreshListener);
    widget.controller._itemChangeNotifier.removeListener(_itemChangedListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isPagination = widget.itemBuilder != null;

    final slivers = <Widget>[
      CupertinoSliverRefreshControl(
        refreshTriggerPullDistance: 80.0,
        refreshIndicatorExtent: 60.0,
        onRefresh: _onRefresh,
        initialRefresh: widget.initialRefresh,
        builder: (context, refreshState, pulledExtent,
            refreshTriggerPullDistance, refreshIndicatorExtent) {
          return SimpleRefreshIndicator(
            refreshState: refreshState,
            pulledExtent: pulledExtent,
            refreshTriggerPullDistance: refreshTriggerPullDistance,
            refreshIndicatorExtent: refreshIndicatorExtent,
            backgroundColor:
                widget.refreshIndicatorBackgroundColor ?? AppColors.transparent,
            color: widget.refreshIndicatorColor,
          );
        },
      ),
    ];

    // 头部
    if (widget.header != null) {
      slivers.add(SliverToBoxAdapter(child: widget.header));
    }

    if ((isPagination && widget.controller._items.isEmpty && _noMoreData) ||
        (!isPagination && widget.children.length == 0)) {
      // 没有数据
      if (_pageIndex >= 0) {
        slivers.add(_emptySliver());
      }
    } else {
      // 有数据
      slivers.add(widget.gridDelegate == null ? _listSliver() : _gridSliver());
      if (isPagination && !_noMoreData) {
        // 还有更多数据的话
        slivers.add(_loadMoreSliver());
      }
    }

    Widget w;
    w = CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: const AlwaysScrollableScrollPhysics(),
      ),
      controller: widget.controller._scrollController,
      slivers: slivers,
    );
    w = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        w,
        ...(!_refreshing
            ? []
            : [
                Container(
                  constraints: BoxConstraints.loose(Size(200, 200)),
                  padding: EdgeInsets.all(24),
                  decoration: const ShapeDecoration(
                    color: AppColors.popupBackground,
                    shape: const RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(20),
                      ),
                    ),
                  ),
                  child: LoadingIndicator(),
                ),
              ]),
      ],
    );
    return w;
  }

  Widget _listSliver() {
    ListView listView;
    if (widget.children != null) {
      listView = ListView(
        children: widget.children,
      );
    } else if (widget.separatorBuilder == null) {
      listView = ListView.builder(
        itemCount: widget.controller._items.length,
        itemBuilder: (BuildContext context, int index) {
          return widget.itemBuilder(
            context,
            widget.controller._items[index],
            index,
          );
        },
      );
    } else {
      listView = ListView.separated(
        itemCount: widget.controller._items.length,
        itemBuilder: (BuildContext context, int index) {
          return widget.itemBuilder(
            context,
            widget.controller._items[index],
            index,
          );
        },
        separatorBuilder: widget.separatorBuilder,
      );
    }

    // 包裹成 Sliver
    Widget w;
    w = SliverList(
      delegate: listView.childrenDelegate,
    );
    return w;
  }

  Widget _gridSliver() {
    GridView gridView;
    gridView = GridView.builder(
      itemCount: widget.controller._items.length,
      gridDelegate: widget.gridDelegate,
      itemBuilder: (BuildContext context, int index) {
        return widget.itemBuilder(
          context,
          widget.controller._items[index],
          index,
        );
      },
    );

    // 包裹成 Sliver
    Widget w;
    w = SliverGrid(
      delegate: gridView.childrenDelegate,
      gridDelegate: gridView.gridDelegate,
    );
    return w;
  }

  Widget _emptySliver() {
    Widget w;
    w = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.info_outline,
          size: 14,
          color: Colors.white70,
        ),
        Text(
          ' 没有记录',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
    w = Container(
      width: double.infinity,
      height: 60,
      alignment: Alignment.center,
      child: w,
    );
    w = IgnorePointer(child: w);

    // 包裹成 Sliver
    w = SliverToBoxAdapter(child: w);
    return w;
  }

  Widget _loadMoreSliver() {
    Widget w;
    w = LoadMoreButton(
      _loadingMore,
      onTap: () {
        _onLoadMore();
      },
    );
    w = Container(
      width: double.infinity,
      height: 60,
      alignment: Alignment.center,
      child: w,
    );

    // 包裹成 Sliver
    w = SliverToBoxAdapter(child: w);
    return w;
  }

  Future _onRefresh() async {
    final bool isPagination = widget.itemBuilder != null;
    try {
      await (isPagination ? _onLoadFirstPage : widget.refreshFuture)();

      // 等待动画结束再 refresh
      while (isInTransition.value) {
        await Future.delayed(Duration(milliseconds: 100));
      }
    } catch (e) {
      if (mounted) {
        showToast(e.toString());
      }
    }
  }

  /// 加载首页数据
  Future _onLoadFirstPage() async {
    // 重置状态
    _pageIndex = 1;
    _noMoreData = false;

    final List<T> page = await widget.pageFuture(_pageIndex++);
    widget.controller._items.clear();
    if (page.length < widget.pageSize) {
      _noMoreData = true;
    }
    widget.controller._items.addAll(page);

    if (mounted) {
      setState(() {});
    }
  }

  /// 加载下一页数据
  Future _onLoadMore() async {
    _loadingMore.value = true;
    List<T> page;
    try {
      page = await widget.pageFuture(_pageIndex++);
    } catch (_) {
      _loadingMore.value = false;
      return;
    }

    if (page.length < widget.pageSize) {
      _noMoreData = true;
    }
    widget.controller._items.addAll(page);
    _loadingMore.value = false;

    if (mounted) {
      setState(() {});
    }
  }
}

class LoadMoreButton extends StatefulWidget {
  final ValueNotifier<bool> loadingMore;
  final VoidCallback onTap;

  const LoadMoreButton(this.loadingMore, {Key key, this.onTap})
      : super(key: key);

  @override
  _LoadMoreButtonState createState() => _LoadMoreButtonState();
}

class _LoadMoreButtonState extends State<LoadMoreButton> {
  VoidCallback _onStateChanged;

  @override
  void initState() {
    super.initState();
    _onStateChanged = () {
      if (mounted) {
        setState(() {});
      }
    };
    widget.loadingMore?.addListener(_onStateChanged);
  }

  @override
  void didUpdateWidget(LoadMoreButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.loadingMore != oldWidget.loadingMore) {
      oldWidget.loadingMore?.removeListener(_onStateChanged);
      widget.loadingMore?.addListener(_onStateChanged);
    }
  }

  @override
  void dispose() {
    widget.loadingMore?.removeListener(_onStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget w;
    w = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.loadingMore?.value != true
          ? <Widget>[
              Icon(
                Icons.all_inclusive,
                size: 14,
                color: Colors.white,
              ),
              Text(
                ' 点击加载更多',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ]
          : [
              LoadingIndicator(
                size: 14,
                beginColor: Colors.white,
                endColor: Colors.white,
              ),
            ],
    );
    w = Button(
      child: w,
      onPressed: () {
        widget.onTap?.call();
      },
    );
    return w;
  }
}
