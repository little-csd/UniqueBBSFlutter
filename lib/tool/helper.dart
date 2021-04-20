import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

const maxInt = 0x7FFFFFFF;

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

String generateMD5(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

String getDayString(String? str) {
  if (str == null) return "";
  final date = DateTime.parse(str);
  if (date == null) return "";
  return "${date.year}.${date.month}.${date.day}";
}

// 用于自动处理 x 小时前这样的数据
String getDeltaTime(String? time) {
  if (time == null) return "";
  final date = DateTime.parse(time);
  if (date == null) return "";
  final delta = DateTime.now().difference(date);
  if (delta.isNegative)
    return "刚刚";
  else if (delta.inDays > 0)
    return "${delta.inDays}天前";
  else if (delta.inHours > 0)
    return "${delta.inHours}小时前";
  else if (delta.inMinutes > 0)
    return "${delta.inMinutes}分钟前";
  else
    return "刚刚";
}

launchBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    Fluttertoast.showToast(msg: 'open for $url failed');
  }
}
