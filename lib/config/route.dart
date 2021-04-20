import 'package:UniqueBBS/data/bean/forum/full_forum.dart';
import 'package:UniqueBBS/data/bean/forum/thread.dart';
import 'package:UniqueBBS/data/bean/report/report.dart';
import 'package:UniqueBBS/widget/home/check/update_user.dart';
import 'package:UniqueBBS/widget/home/home.dart';
import 'package:UniqueBBS/widget/home/home_select.dart';
import 'package:UniqueBBS/widget/login/info_set.dart';
import 'package:UniqueBBS/widget/login/login.dart';
import 'package:UniqueBBS/widget/login/pw_set.dart';
import 'package:UniqueBBS/widget/post/detail/post_detail.dart';
import 'package:UniqueBBS/widget/post/thread_page.dart';
import 'package:UniqueBBS/widget/report/report_page.dart';
import 'package:UniqueBBS/widget/report/report_post_page.dart';
import 'package:flutter/material.dart';

class BBSRoute {
  static const main = '/'; // 主页

  static const home = 'home'; // 首页
  static const information = 'information'; // 首页-情报
  static const forum = 'forum'; // 首页-论坛
  static const search = 'search'; // 首页-搜索
  static const selectPlate = 'select plate';
  static const reportPage = 'report';

  static const login = 'login'; // 登录

  static const postList = 'postList'; // 帖子列表：首页-情报-通知公告、首页-我的-我的帖子
  static const postDetail = 'postDetail'; // 帖子详情
  static const postReport = 'postReport'; // 发日报

  static const pwUpdate = 'pwUpdate'; // 修改密码
  static const pwSet = 'pwSet'; // 设置密码
  static const infoSet = 'infoSet'; // 用户信息设置

  static const message = 'message'; // 消息页面
  static const userInfoUpdate = 'userInfoUpdate';

  // TODO: 不需要传参的路由在这里进行声明
  static final routes = {
    home: HomeWidget(),
    selectPlate: HomeSelectWidget(),
    login: LoginWidget(),
    pwSet: PasswordSetWidget(),
    infoSet: InfoSetWidget(),
    reportPage: ReportPageWidget(),
    userInfoUpdate: UserUpdateWidget(),
  };

  // 用来给给所有 route 添加特性
  // 目前只有一个 safeArea
  static WidgetBuilder generateBuilder(Widget? child) {
    return (context) => Container(
          color: Colors.white,
          child: SafeArea(
            top: false,
            child: child!,
          ),
        );
  }

  static Route buildPage(String? path, dynamic arg) {
    if (routes.containsKey(path)) {
      return MaterialPageRoute(builder: generateBuilder(routes[path!]));
    }
    // used for build page with arguments
    switch (path) {
      case postDetail:
        return MaterialPageRoute(
            builder: generateBuilder(PostDetailWidget(arg as Thread)));
      case postList:
        return MaterialPageRoute(
            builder: generateBuilder(ThreadPageWidget(arg as FullForum?)));
      case postReport:
        return MaterialPageRoute(
            builder: generateBuilder(ReportPostPageWidget(arg as Report?)));
    }
    throw Exception("Route $path not found!");
  }
}
