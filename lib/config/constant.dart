import 'dart:ui';

import 'package:flutter/material.dart';

// 颜色相关的资源常量
class ColorConstant {
  // 文本颜色常量
  static const textGray = Color(0xff999999);
  static const textBlack = Colors.black;
  static const textWhite = Colors.white;

  // 前景色颜色常量
  static const primaryColor = Color(0xff7966FF);
  static const primaryColorLight = Color(0xFFFFDFFD);
  static const purpleColor = Color(0xFF7966FF);
  static const accentColor = Color(0xff555555);
  static const backgroundGray = Color(0xfffafafa);
  static const backgroundWhite = Colors.white;

  // 阴影相关颜色常量
  static const borderGray = Color(0xffe6e6e6);
  static const lightBorderPink = Color(0xFFF8F3FF);
}

// 字符串相关的资源常量
class StringConstant {
  // 首页常量
  static const info = '正事';
  static const forum = '放飞';
  static const home = '首页';
  static const me = '我的';
  static const broadcast = '通知公告';
  static const showReport = '查看 report';
  static const projectTask = '项目任务';
  static const freshmanTask = '新人任务';
  static const fileData = '文件留存';
  static const share = '交流分享';

  static const edit = '编辑';
  static const delete = '删除';
  static const newComment = '最新评论';
}

class SvgIcon {
  static final _base = 'images/';

  static final notification = _base + 'notification.svg';
  static final message = _base + 'message.svg';
  static final person = _base + 'person.svg';
  static final search = _base + 'search.svg';
  static final file = _base + 'file.svg';
  static final freshmanTask = _base + 'freshman_task.svg';
  static final projectTask = _base + 'project_task.svg';
  static final share = _base + 'share.svg';
  static final broadcast = _base + 'broadcast.svg';
}
