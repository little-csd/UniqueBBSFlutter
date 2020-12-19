import 'dart:ui';

import 'package:flutter/material.dart';

// 颜色相关的资源常量
class ColorConstant {
  // 文本颜色常量
  static const textGrey = Color(0xFF999999);
  static const textBlack = Colors.black;
  static const textWhite = Colors.white;
  static const textRed = Color(0xFFFF7A7A);

  // 前景色/背景色颜色常量
  static const primaryColor = Color(0xFF7966FF);
  static const primaryColorLight = Color(0xFFFFDFFD);
  static const primaryColorTransparent = Color(0x1F7966FF);
  static const purpleColor = Color(0xFF7966FF);
  static const accentColor = Color(0xff555555);
  static const backgroundLightGrey = Color(0xFFFaFaFa);
  static const backgroundGrey = Color(0xFFCCCBD8);
  static const backgroundWhite = Colors.white;
  static const backgroundBlack = Colors.black;

  // 阴影相关颜色常量
  static const borderGray = Color(0xFFE6E6E6);
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
  // 选择发帖板块界面常量
  static const selectBlockHint = '请先选择发帖板块';
  // '我的'界面的常量
  static const activePoint = '活跃积分';
  static const signature = '签名';
  static const phoneNumber = '手机号';
  static const wechat = '微信';
  static const mailbox = '邮箱';
  static const birthday = '生日';
  static const showMyPost = '查看我的帖子';
  static const changePassword = '修改密码';
  static const logout = '退出登录';
  // toast 常量
  static const LoginSuccess = '登录成功!';

  static const edit = '编辑';
  static const delete = '删除';
  static const newComment = '最新评论';
}

class SvgIcon {
  static const _base = 'images/';

  static const notification = _base + 'notification.svg';
  static const message = _base + 'message.svg';
  static const person = _base + 'person.svg';
  static const search = _base + 'search.svg';
  static const file = _base + 'file.svg';
  static const freshmanTask = _base + 'freshman_task.svg';
  static const projectTask = _base + 'project_task.svg';
  static const share = _base + 'share.svg';
  static const broadcast = _base + 'broadcast.svg';

  static const selectPlateIcon = _base + 'select_plate_icon.svg';
  static const selectPlateCancel = _base + 'select_plate_cancel.svg';

  static const phoneNumber = _base + 'phone_icon.svg';
  static const wechat = _base + 'wechat_icon.svg';
  static const mailbox = _base + 'mailbox_icon.svg';
  static const birthday = _base + 'birthday_icon.svg';

  static const logo = _base + 'logo.svg';
}
