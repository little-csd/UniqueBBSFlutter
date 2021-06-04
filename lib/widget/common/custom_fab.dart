import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:unique_bbs/config/constant.dart';

// 动画相关参数
const _maxDist = 70.0;
const _maxAngle = pi / 2;
const _animationDuration = 500;
// 中间按钮参数
const _mainBtnSize = 70.0;
const _mainBtnIconSize = 35.0;
const _mainBtnOffset = 5.0;
// 子结点参数
const _childBtnSize = 55.0;
final _childTextStyle =
    TextStyle(fontSize: 15, color: ColorConstant.primaryColor);

class CustomFAB extends StatefulWidget {
  CustomFAB(this.children, this.callbacks)
      : assert(children.length == callbacks.length);

  final List<String> children;
  final List<VoidCallback> callbacks;

  @override
  State createState() => _CustomFABState();
}

class _CustomFABState extends State<CustomFAB>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController = AnimationController(
      vsync: this, duration: Duration(milliseconds: _animationDuration))
    ..addListener(() {
      setState(() {});
    });
  late Animation<double> _translateButton =
      Tween<double>(begin: 0, end: _maxDist).animate(CurvedAnimation(
    parent: _animationController,
    curve: Interval(
      0.0,
      0.75,
      curve: Curves.easeOut,
    ),
  ));

  double _deltaAngle = 0;
  double _anglePadding = pi / 18;

  _animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget _mainButton() {
    return MaterialButton(
      height: _mainBtnSize,
      shape: CircleBorder(),
      color: Colors.white,
      padding: EdgeInsets.only(bottom: _mainBtnOffset),
      onPressed: _animate,
      child: SvgPicture.asset(
        SvgIcon.report,
        width: _mainBtnIconSize,
        height: _mainBtnIconSize,
      ),
    );
  }

  Widget _wrapWidget(String text, int factor, VoidCallback callback) {
    double base = _translateButton.value;
    double dx = sin(_deltaAngle * factor + _anglePadding);
    double dy = cos(_deltaAngle * factor + _anglePadding);
    double offset = (_mainBtnSize - _childBtnSize) / 2;
    return Padding(
      padding: EdgeInsets.only(right: dx * base, bottom: dy * base + offset),
      child: MaterialButton(
        height: _childBtnSize,
        shape: CircleBorder(),
        onPressed: callback,
        color: ColorConstant.backgroundWhite,
        child: Text(
          text,
          style: _childTextStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = widget.children;
    if (children.length <= 1) {
      _anglePadding = _maxAngle / 2;
    } else {
      _deltaAngle = (_maxAngle - 2 * _anglePadding) / (children.length - 1);
    }
    int base = 0;
    List<Widget> replace = <Widget>[];
    for (String text in children) {
      replace.add(_wrapWidget(text, base, widget.callbacks[base]));
      base++;
    }
    replace.add(_mainButton());
    return Stack(alignment: Alignment.bottomRight, children: replace);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
