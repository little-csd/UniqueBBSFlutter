import 'dart:math';

import 'package:flutter/material.dart';

Widget wrapPadding(Widget child, double vertical, double horizontal) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
    child: child,
  );
}

// 用于颜色的插值, 给定角度转化得到线性插值的起点+终点的 Alignment
List<Alignment> transAngle2Alignments(double angle) {
  angle = angle / 180 * pi;
  final y = tan(angle);
  Alignment start, end;
  if (y > 1 || y < -1) {
    start = Alignment(-1 / y, -1);
    end = Alignment(1 / y, 1);
  } else {
    start = Alignment(-1, -y);
    end = Alignment(1, y);
  }
  return [start, end];
}
