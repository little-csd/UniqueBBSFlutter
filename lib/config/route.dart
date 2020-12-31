import 'package:UniqueBBSFlutter/data/bean/forum/full_forum.dart';
import 'package:UniqueBBSFlutter/data/bean/forum/thread.dart';
import 'package:UniqueBBSFlutter/widget/post/thread_page.dart';
import 'package:UniqueBBSFlutter/widget/home/home.dart';
import 'package:UniqueBBSFlutter/widget/home/home_select.dart';
import 'package:UniqueBBSFlutter/widget/login/info_set.dart';
import 'package:UniqueBBSFlutter/widget/login/login.dart';
import 'package:UniqueBBSFlutter/widget/login/pw_set.dart';
import 'package:UniqueBBSFlutter/widget/post/detail/post_detail.dart';
import 'package:UniqueBBSFlutter/widget/report/report_page.dart';
import 'package:UniqueBBSFlutter/widget/report/report_post_page.dart';
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

  // TODO: 不需要传参的路由在这里进行声明
  static final routes = {
    home: (context) => HomeWidget(),
    selectPlate: (context) => HomeSelectWidget(),
    login: (context) => LoginWidget(),
    pwSet: (context) => PasswordSetWidget(),
    infoSet: (context) => InfoSetWidget(),
    reportPage: (context) => ReportPageWidget(),
    postReport: (context) => ReportPostPageWidget(),
  };

  static Route buildPage(String path, dynamic arg) {
    if (routes.containsKey(path)) {
      return MaterialPageRoute(builder: routes[path]);
    }
    // used for build page with arguments
    // now only throw an exception
    switch (path) {
      case postDetail:
        return MaterialPageRoute(
            builder: (context) => PostDetailWidget(arg as Thread));
      case postList:
        return MaterialPageRoute(builder: (context) => ThreadPageWidget(arg as FullForum));
    }
    throw Exception("Route $path not found!");
  }
}
