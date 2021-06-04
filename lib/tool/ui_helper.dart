import 'package:flutter/material.dart';
import 'package:unique_bbs/config/constant.dart';

Widget wrapPadding(Widget child, double vertical, double horizontal) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
    child: child,
  );
}

Widget wrapRedPoint(Widget child, bool isRed) {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      Container(
        padding: EdgeInsets.only(right: 3, top: 3),
        child: child,
      ),
      if (isRed)
        Container(
          width: 6,
          height: 6,
          // margin: EdgeInsets.only(right: -3, top: -3),
          decoration: BoxDecoration(
            color: ColorConstant.redPointColor,
            shape: BoxShape.circle,
          ),
        ),
    ],
  );
}
