import 'package:flutter/material.dart';

class ListStagger<T> extends StatefulWidget {
  const ListStagger({super.key, required this.itemWidget, required this.list});
  final List<T> list;
  final Widget Function(T) itemWidget;

  @override
  State<ListStagger<T>> createState() => _ListStaggerState<T>();
}

class _ListStaggerState<T> extends State<ListStagger<T>>
    with SingleTickerProviderStateMixin {
  late AnimationController _staggeredController;

  static const _initialDelayTime = Duration(milliseconds: 50);
  static const _itemSlideTime = Duration(milliseconds: 250);
  static const _staggerTime = Duration(milliseconds: 100);
  static const _buttonDelayTime = Duration(milliseconds: 150);
  static const _buttonTime = Duration(milliseconds: 500);
  late Duration _animationDuration;

  final List<Interval> _itemSlideIntervals = [];

  @override
  void initState() {
    super.initState();
    _animationDuration = _initialDelayTime +
        (_staggerTime * widget.list.length) +
        _buttonDelayTime +
        _buttonTime;
    _createAnimationIntervals();

    _staggeredController =
        AnimationController(vsync: this, duration: _animationDuration)
          ..forward();
  }

  @override
  void dispose() {
    _staggeredController.dispose();
    super.dispose();
  }

  void _createAnimationIntervals() {
    for (var i = 0; i < widget.list.length; ++i) {
      final startTime = _initialDelayTime + (_staggerTime * i);
      final endTime = startTime + _itemSlideTime;
      _itemSlideIntervals.add(
        Interval(
          startTime.inMilliseconds / _animationDuration.inMilliseconds,
          endTime.inMilliseconds / _animationDuration.inMilliseconds,
        ),
      );
    }
  }

  List<Widget> _buildListItems() {
    final listItems = <Widget>[];
    for (var i = 0; i < widget.list.length; ++i) {
      listItems.add(
        AnimatedBuilder(
            animation: _staggeredController,
            builder: (context, child) {
              final animationPercent = Curves.easeOut.transform(
                _itemSlideIntervals[i].transform(_staggeredController.value),
              );
              final opacity = animationPercent;
              final slideDistance = (1.0 - animationPercent) * 150;

              return Opacity(
                opacity: opacity,
                child: Transform.translate(
                  offset: Offset(slideDistance, 0),
                  child: child,
                ),
              );
            },
            child: widget.itemWidget(widget.list[i])),
      );
    }
    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: _buildListItems(),
      ),
    );
  }
}
