// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../loading.dart';

class _CupertinoSliverRefresh extends SingleChildRenderObjectWidget {
  const _CupertinoSliverRefresh({
    Key key,
    this.refreshIndicatorLayoutExtent = 0.0,
    this.hasLayoutExtent = false,
    Widget child,
  })  : assert(refreshIndicatorLayoutExtent != null),
        assert(refreshIndicatorLayoutExtent >= 0.0),
        assert(hasLayoutExtent != null),
        super(key: key, child: child);

  final double refreshIndicatorLayoutExtent;

  final bool hasLayoutExtent;

  @override
  _RenderCupertinoSliverRefresh createRenderObject(BuildContext context) {
    return _RenderCupertinoSliverRefresh(
      refreshIndicatorExtent: refreshIndicatorLayoutExtent,
      hasLayoutExtent: hasLayoutExtent,
    );
  }

  @override
  void updateRenderObject(BuildContext context,
      covariant _RenderCupertinoSliverRefresh renderObject) {
    renderObject
      ..refreshIndicatorLayoutExtent = refreshIndicatorLayoutExtent
      ..hasLayoutExtent = hasLayoutExtent;
  }
}

class _RenderCupertinoSliverRefresh extends RenderSliver
    with RenderObjectWithChildMixin<RenderBox> {
  _RenderCupertinoSliverRefresh({
    @required double refreshIndicatorExtent,
    @required bool hasLayoutExtent,
    RenderBox child,
  })  : assert(refreshIndicatorExtent != null),
        assert(refreshIndicatorExtent >= 0.0),
        assert(hasLayoutExtent != null),
        _refreshIndicatorExtent = refreshIndicatorExtent,
        _hasLayoutExtent = hasLayoutExtent {
    layoutExtentOffsetCompensation =
        (hasLayoutExtent ? 1.0 : 0.0) * refreshIndicatorExtent;
    this.child = child;
  }

  double get refreshIndicatorLayoutExtent => _refreshIndicatorExtent;
  double _refreshIndicatorExtent;

  set refreshIndicatorLayoutExtent(double value) {
    assert(value != null);
    assert(value >= 0.0);
    if (value == _refreshIndicatorExtent) return;
    _refreshIndicatorExtent = value;
    markNeedsLayout();
  }

  bool get hasLayoutExtent => _hasLayoutExtent;
  bool _hasLayoutExtent;

  set hasLayoutExtent(bool value) {
    assert(value != null);
    if (value == _hasLayoutExtent) return;
    _hasLayoutExtent = value;
    markNeedsLayout();
  }

  double layoutExtentOffsetCompensation = 0.0;

  @override
  void performLayout() {
    final SliverConstraints constraints = this.constraints;
    assert(constraints.axisDirection == AxisDirection.down);
    assert(constraints.growthDirection == GrowthDirection.forward);

    final double layoutExtent =
        (_hasLayoutExtent ? 1.0 : 0.0) * _refreshIndicatorExtent;
    if (layoutExtent != layoutExtentOffsetCompensation) {
      geometry = SliverGeometry(
        scrollOffsetCorrection: layoutExtent - layoutExtentOffsetCompensation,
      );
      layoutExtentOffsetCompensation = layoutExtent;
      return;
    }

    final bool active = constraints.overlap < 0.0 || layoutExtent > 0.0;
    final double overscrolledExtent =
        constraints.overlap < 0.0 ? constraints.overlap.abs() : 0.0;
    child.layout(
      constraints.asBoxConstraints(
        maxExtent: layoutExtent +
            overscrolledExtent
            // 避免出现白线
            +
            1,
      ),
      parentUsesSize: true,
    );
    if (active) {
      geometry = SliverGeometry(
        scrollExtent: layoutExtent,
        paintOrigin: -overscrolledExtent - constraints.scrollOffset,
        paintExtent: max(
          max(child.size.height, layoutExtent) - constraints.scrollOffset,
          0.0,
        ),
        maxPaintExtent: max(
          max(child.size.height, layoutExtent) - constraints.scrollOffset,
          0.0,
        ),
        layoutExtent: max(layoutExtent - constraints.scrollOffset, 0.0),
      );
    } else {
      geometry = SliverGeometry.zero;
    }
  }

  @override
  void paint(PaintingContext paintContext, Offset offset) {
    if (constraints.overlap < 0.0 ||
        constraints.scrollOffset + child.size.height > 0) {
      paintContext.paintChild(child, offset);
    }
  }

  @override
  void applyPaintTransform(RenderObject child, Matrix4 transform) {}
}

enum RefreshIndicatorMode {
  initialRefresh,
  inactive,
  drag,
  armed,
  refresh,
  done,
}

typedef RefreshControlIndicatorBuilder = Widget Function(
  BuildContext context,
  RefreshIndicatorMode refreshState,
  double pulledExtent,
  double refreshTriggerPullDistance,
  double refreshIndicatorExtent,
);

typedef RefreshCallback = Future<void> Function();

const double _defaultRefreshTriggerPullDistance = 100.0;
const double _defaultRefreshIndicatorExtent = 60.0;

class SimpleRefreshIndicator extends StatelessWidget {
  const SimpleRefreshIndicator({
    Key key,
    @required this.refreshState,
    @required this.pulledExtent,
    @required this.refreshTriggerPullDistance,
    @required this.refreshIndicatorExtent,
    this.backgroundColor,
    this.color,
  }) : super(key: key);

  final RefreshIndicatorMode refreshState;
  final double pulledExtent;
  final double refreshTriggerPullDistance;
  final double refreshIndicatorExtent;
  final Color backgroundColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    const Curve opacityCurve = Interval(0.4, 0.8, curve: Curves.easeInOut);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: refreshState == RefreshIndicatorMode.drag
              ? Opacity(
                  opacity: opacityCurve.transform(
                      min(pulledExtent / refreshTriggerPullDistance, 1.0)),
                  child: Icon(
                    Icons.arrow_downward,
                    color: color ?? Theme.of(context).accentColor,
                    size: 18.0,
                  ),
                )
              : Opacity(
                  opacity: opacityCurve.transform(
                      min(pulledExtent / refreshIndicatorExtent, 1.0)),
                  child: LoadingIndicator(),
                ),
        ),
      ),
    );
  }
}

Widget _buildSimpleRefreshIndicator(
  BuildContext context,
  RefreshIndicatorMode refreshState,
  double pulledExtent,
  double refreshTriggerPullDistance,
  double refreshIndicatorExtent,
) {
  return SimpleRefreshIndicator(
    refreshState: refreshState,
    pulledExtent: pulledExtent,
    refreshTriggerPullDistance: refreshTriggerPullDistance,
    refreshIndicatorExtent: refreshIndicatorExtent,
  );
}

class CupertinoSliverRefreshControl extends StatefulWidget {
  const CupertinoSliverRefreshControl({
    Key key,
    this.refreshTriggerPullDistance = _defaultRefreshTriggerPullDistance,
    this.refreshIndicatorExtent = _defaultRefreshIndicatorExtent,
    this.builder = _buildSimpleRefreshIndicator,
    this.onRefresh,
    this.initialRefresh = true,
  })  : assert(refreshTriggerPullDistance != null),
        assert(refreshTriggerPullDistance > 0.0),
        assert(refreshIndicatorExtent != null),
        assert(refreshIndicatorExtent >= 0.0),
        assert(
            refreshTriggerPullDistance >= refreshIndicatorExtent,
            'The refresh indicator cannot take more space in its final state '
            'than the amount initially created by overscrolling.'),
        super(key: key);

  final double refreshTriggerPullDistance;
  final double refreshIndicatorExtent;
  final RefreshControlIndicatorBuilder builder;
  final RefreshCallback onRefresh;

  /// 是否在初始化时触发一次刷新
  final bool initialRefresh;

  @visibleForTesting
  static RefreshIndicatorMode state(BuildContext context) {
    final _CupertinoSliverRefreshControlState state =
        context.findAncestorStateOfType<_CupertinoSliverRefreshControlState>();
    return state.refreshState;
  }

  @override
  _CupertinoSliverRefreshControlState createState() =>
      _CupertinoSliverRefreshControlState();
}

class _CupertinoSliverRefreshControlState
    extends State<CupertinoSliverRefreshControl> {
  static const double _inactiveResetOverscrollFraction = 0.1;

  RefreshIndicatorMode refreshState;
  bool needRefresh = false;
  double latestIndicatorBoxExtent = 0.0;
  bool hasSliverLayoutExtent;

  @override
  void initState() {
    super.initState();
    refreshState = widget.initialRefresh
        ? RefreshIndicatorMode.initialRefresh
        : RefreshIndicatorMode.inactive;
    hasSliverLayoutExtent = widget.initialRefresh;
  }

  RefreshIndicatorMode transitionNextState() {
    RefreshIndicatorMode nextState;

    void goToDone() {
      nextState = RefreshIndicatorMode.done;
      if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.idle) {
        setState(() => hasSliverLayoutExtent = false);
      } else {
        SchedulerBinding.instance.addPostFrameCallback((Duration timestamp) {
          if (mounted) {
            setState(() => hasSliverLayoutExtent = false);
          }
        });
      }
    }

    void needGoToRefresh() {
      needRefresh = true;
      if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.idle) {
        setState(() => hasSliverLayoutExtent = true);
      } else {
        SchedulerBinding.instance.addPostFrameCallback((Duration timestamp) {
          if (mounted) {
            setState(() => hasSliverLayoutExtent = true);
          }
        });
      }
    }

    switch (refreshState) {
      case RefreshIndicatorMode.initialRefresh:
        needRefresh = true;
        widget.onRefresh()
          ..whenComplete(() {
            if (mounted) {
              setState(() => needRefresh = false);
            }
          });
        return RefreshIndicatorMode.refresh;
      case RefreshIndicatorMode.inactive:
        if (latestIndicatorBoxExtent <= 0) {
          return RefreshIndicatorMode.inactive;
        } else {
          nextState = RefreshIndicatorMode.drag;
        }
        continue drag;
      drag:
      case RefreshIndicatorMode.drag:
        if (latestIndicatorBoxExtent == 0) {
          return RefreshIndicatorMode.inactive;
        } else if (latestIndicatorBoxExtent <
            widget.refreshTriggerPullDistance) {
          return RefreshIndicatorMode.drag;
        } else {
          if (widget.onRefresh != null) {
            HapticFeedback.mediumImpact();
            needGoToRefresh();
          }
          return RefreshIndicatorMode.armed;
        }
        break;
      case RefreshIndicatorMode.armed:
        if (refreshState == RefreshIndicatorMode.armed && needRefresh != true) {
          goToDone();
          continue done;
        }

        if (latestIndicatorBoxExtent - 1 > widget.refreshIndicatorExtent) {
          return RefreshIndicatorMode.armed;
        } else {
          widget.onRefresh()
            ..whenComplete(() {
              if (mounted) {
                setState(() => needRefresh = false);
              }
            });
          nextState = RefreshIndicatorMode.refresh;
        }
        continue refresh;
      refresh:
      case RefreshIndicatorMode.refresh:
        if (needRefresh == true) {
          return RefreshIndicatorMode.refresh;
        } else {
          goToDone();
        }
        continue done;
      done:
      case RefreshIndicatorMode.done:
        if (latestIndicatorBoxExtent >
            widget.refreshTriggerPullDistance *
                _inactiveResetOverscrollFraction) {
          return RefreshIndicatorMode.done;
        } else {
          nextState = RefreshIndicatorMode.inactive;
        }
        break;
    }

    return nextState;
  }

  @override
  Widget build(BuildContext context) {
    return _CupertinoSliverRefresh(
      refreshIndicatorLayoutExtent: widget.refreshIndicatorExtent,
      hasLayoutExtent: hasSliverLayoutExtent,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          latestIndicatorBoxExtent = constraints.maxHeight;
          refreshState = transitionNextState();
          if (widget.builder != null && latestIndicatorBoxExtent > 0) {
            return widget.builder(
              context,
              refreshState,
              latestIndicatorBoxExtent,
              widget.refreshTriggerPullDistance,
              widget.refreshIndicatorExtent,
            );
          }
          return Container();
        },
      ),
    );
  }
}
