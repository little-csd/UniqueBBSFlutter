import 'dart:ui';

import 'package:flutter/material.dart';

// 颜色相关的资源常量
class ColorConstant {
  // 文本颜色常量
  static const textGrey = Color(0xFF999999);
  static const textBlack = Colors.black;
  static const textWhite = Colors.white;
  static const textRed = Color(0xFFFF7A7A);
  static const textForLogo = Color(0xFF727272);
  static const textLightPurPle = Color(0xFF9B84FE);
  static const textPostPurple = Color(0xFFB4AAFD);
  static const textMediumBlack = Color(0xFF616161);
  static const textLightBlack = Color(0xFF555555);
  static const textLightGrey = Color(0xFFB4B4B4);
  static const textGreyForComment = Color(0xFFD3CFE9);
  static const textGreyForNoComment = Color(0xFFE1DDF7);
  static const textPurpleForReply = Color(0xFF6B6BA1);
  static const textPurpleForUpdate = Color(0xFF7966FF);
  static const textGreyForUpdate = Color(0xFF555555);

  // 前景色/背景色颜色常量
  static const primaryColor = Color(0xFF7966FF);
  static const primaryColorLight = Color(0xFFFFDFFD);
  static const primaryColorTransparent = Color(0x1F7966FF);
  static const purpleColor = Color(0xFF7966FF);
  static const accentColor = Color(0xff555555);
  static const weComButtonGray = Color(0xFF707070);
  static const inputPurple = Color(0xFFF0F0F6);
  static const inputHintPurple = Color(0xFFCECAE7);
  static const textBackgroundLightPurple = Color(0xFFA598FF);
  static const iconLightGrey = Color(0xFFE3E3E3);
  static const redPointColor = Color(0xFFFF1313);
  static const invisibleWhite = Color(0x00FFFFFF);
  static const invisible = Colors.transparent;

  static const backgroundForAppSplash = Color(0xFFF7F7F7);
  static const backgroundLightGrey = Color(0xFFFAFAFA);
  static const backgroundGreyForComment = Color(0xFFF0F0F6);
  static const backgroundGrey = Color(0xFFCCCBD8);
  static const backgroundPurple = Color(0xFFCCC5EA);
  static const backgroundLightShadow = Color(0x7FCCC5EA);
  static const backgroundLightPurple = Color(0x50CCC5EA);
  static const backgroundLighterShadow = Color(0x29CCC5EA);
  static const backgroundWhite = Colors.white;
  static const backgroundBlack = Colors.black;

  // 阴影相关颜色常量
  static const borderGray = Color(0xFFE6E6E6);
  static const borderLightPink = Color(0xFFF8F3FF);
  static const borderPurple = Color(0x297668AF);
}

// 字符串相关的资源常量
class StringConstant {
  static const uniqueStudio = '联创团队';
  // 首页常量
  static const info = '正事';
  static const forum = '放飞';
  static const home = '首页';
  static const me = '我的';
  static const post = '发布';
  static const broadcast = '通知公告';
  static const report = 'Report';
  static const uniqueMarket = '联创市场';
  static const uniqueProject = '团队项目';
  static const freshmanTask = '新人任务';
  static const uniqueData = '团队资料';
  static const uniqueShare = '团队分享';
  static const discussion = '闲杂讨论';
  // report
  static const reportTitle = '我的 report';
  static const postReportTitle = '发布 report';
  static const pleaseInput = '请输入正文';
  static const postReportSuccess = '发布成功';
  static const updateReportSuccess = '修改成功';
  static const noPostEmpty = '请勿发布空消息';
  static const noReportPost = '没有获取到你的日报噢~';
  // 帖子列表
  static const loadMore = '查看更多';
  static const noMoreForum = "再往下拉也没有啦~";
  static const myThreads = '我的帖子';
  // 帖子浏览
  static const comment = '评论';
  static const edit = '编辑';
  static const delete = '删除';
  static const comments = '最新评论';
  static const noComment = '快来评论吧';
  static const sendPostSuccess = '发帖成功';
  static const sendPostError = '发帖错误: ';
  static const sendPostFail = '发帖失败: 没有权限或内容为空';
  // 网络异常页
  static const networkError = '你的网络好像走丢了\n请试试重新连接吧？';
  // 登陆页
  static const logo2Line = "UNIQUE\nSTUDIO";
  static const phoneNumber = "用户名";
  static const password = "密码";
  static const noPhoneNumber = "用户名未注册，\n用企业微信登录试试吧？";
  static const login = "登录";
  static const iKnow = "我知道了";
  static const useWeComLogin = "使用企业微信扫码登录";
  static const usernameEmpty = "用户名不能为空";
  static const passwordEmpty = "密码不能为空";
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
  static const completePasswordLabel = "请设置你的登陆密码\n方便你以后的登陆噢";
  static const passwordTips = "6-10位数，支持大小写英文字符和数字";
  static const confirmPassword = "确认密码";
  static const complete = "完成";
  // 个人信息修改页
  static const saveString = "保存";
  static const errorPost = '提交失败，是不是网络开小差了?';
  static const infoWrong = '输入格式有问题，检查检查?';
  static const successPost = '提交成功!';
  // 修改密码页
  static const changeInfo = "修改我的资料";
  static const changePassword = "修改密码";
  static const confirm = "确认";
  static const inputPassword = "输入密码";
  static const confirmPasswordAgain = "再次确认密码";
  // 选择发帖板块界面常量
  static const selectBlockHint = '请先选择发帖板块';
  // '我的'界面的常量
  static const activePoint = '活跃积分';
  static const signature = '签名';
  static const mailbox = '邮箱';
  static const showMyPost = '查看我的帖子';
  static const logout = '退出登录';
  static const noData = '无';
  // toast 常量
  static const loginSuccess = '登录成功!';
  // hero tag
  static const selectPlateHero = "select plate";
  // 其他
  static const globalFont = "PingFang";
  static const noQuote = "-1";
  static const threadClosed = "帖子已关闭!";
  static const jwtExpired = "jwt expired";
  static const jwtMalformed = "jwt malformed";
  static const notImpl = "此功能尚待开发";
  static const uniqueScheme = 'unique';
  static const networkProtocol = 'https';
  static const unknown = "未知错误";
}

// 存放资源的一些常量
const _base = 'images';
const _home = '$_base/home';
const _me = '$_base/me';
const _post = '$_base/post';

// svg 图片按界面划分
class SvgIcon {
  // 主页
  static const notification = '$_home/notification.svg';
  static const message = '$_home/message.svg';
  static const person = '$_home/person.svg';
  static const search = '$_home/search.svg';
  static const file = '$_home/file.svg';
  static const market = '$_home/market.svg';
  static const report = '$_home/report.svg';
  static const freshmanTask = '$_home/freshman_task.svg';
  static const projectTask = '$_home/project_task.svg';
  static const share = '$_home/share.svg';
  static const homeBottomBg = '$_home/home_bottom_bg.svg';
  static const homeBottomBtn = '$_home/home_bottom_btn.svg';
  static const broadcast = '$_home/broadcast.svg';
  static const discussion = '$_home/discussion.svg';
  // 我的
  static const phoneNumber = '$_me/phone_icon.svg';
  static const weChat = '$_me/wechat_icon.svg';
  static const mailbox = '$_me/mailbox_icon.svg';
  static const birthday = '$_me/birthday_icon.svg';
  // 帖子
  static const like = '$_post/like.svg';
  static const comment = '$_post/comment.svg';
  static const star = '$_post/star.svg';
  // report
  static const postReport = _base + '/post_report.svg';
  static const moduleChooseTag = _base + '/module_choose_tag.svg';

  static const loginLogo = _base + "/login_logo.svg";
  static const doubt = _base + "/jyr_doubt.svg";
  static const setInfo = _base + "/set_info.svg";
  static const error = _base + "/no_phone_number.svg";
  // 选择发帖板块页
  static const selectPlateIcon = _base + '/select_plate_icon.svg';
  // 其他
  static const defaultAvatar = _base + '/default_avatar.svg';
}

/// 某些图片不适合使用 svg(比如图片过于复杂或者 SvgPicture 这个库的加载太慢)
/// 因此用 png 的格式存储
class PngIcon {
  static const splashLogo = _base + "/logo.png";
  static const homeForumBg = _base + "/home_forum_bg.png";
}

class HyperParam {
  static const requestInterval = 5;
  static const pageSize = 20;
}
