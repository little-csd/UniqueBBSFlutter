import 'dart:ui';

import 'package:flutter/material.dart';

// 颜色相关的资源常量
class ColorConstant {
  // 文本颜色常量
  static const textGrey = Color(0xFF999999);
  static const textBlack = Colors.black;
  static const textWhite = Colors.white;

  // 前景色/背景色颜色常量
  static const primaryColor = Color(0xFF7966FF);
  static const primaryColorLight = Color(0xFFFFDFFD);
  static const purpleColor = Color(0xFF7966FF);
  static const accentColor = Color(0xff555555);
  static const skyButtonGray = Color(0xff707070);
  static const skyInputPurple = Color(0xfff0f0f6);
  static const skyInputHintPurple = Color(0xffcecae7);

  static const backgroundLightGrey = Color(0xFFFaFaFa);
  static const backgroundGrey = Color(0xFFCCCBD8);
  static const backgroundWhite = Colors.white;

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
  static const networkError = '你的网络好像走丢了\n请试试重新连接吧？';
  // 登陆页
  static const logo2Line = "UNIQUE\nSTUDIO";
  static const phoneNumber = "手机号";
  static const password = "密码";
  static const noPhoneNumber = "手机号未注册，\n用企业微信登录试试吧？";
  static const login = "登陆";
  static const iKnow = "我知道了";
  static const useWeComLogin = "使用企业微信扫码登录";
  // 完善信息页
  static const userInfoLabel = "请完善你的个人信息\n让我们更了解你吧";
  static const qq = "QQ";
  static const weChat = "微信";
  static const birthday = "生日";
  static const year = "年份";
  static const mouth = "月份";
  static const day = "日";
  static const nextStep = "继续";
  static const jumpOver = "跳过";
  // 完善密码页
  static const completePasswordLabel = "请你设置你的登陆密码\n方便你以后的登陆噢";
  static const passwordTips = "6-10位数，支持大小写英文字符和数字";
  static const confirmPassword = "确认密码";
  static const complete = "完成";
  // 修改密码页
  static const changePassword = "修改密码";
  static const confirm = "确认";
  static const inputPassword = "输入密码";
  static const confirmPasswordAgain = "再次确认密码";

  static const selectBlockHint = '请先选择发帖板块';

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
  static const logo = _base + "login_logo.svg";
  static const error = _base + "no_phone_number.svg";

      static const selectPlateIcon = _base + 'select_plate_icon.svg';
  static const selectPlateCancel = _base + 'select_plate_cancel.svg';
}
