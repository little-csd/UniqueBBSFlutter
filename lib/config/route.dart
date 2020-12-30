import 'package:UniqueBBSFlutter/data/bean/forum/thread.dart';
import 'package:UniqueBBSFlutter/widget/home/home.dart';
import 'package:UniqueBBSFlutter/widget/home/home_select.dart';
import 'package:UniqueBBSFlutter/widget/login/info_set.dart';
import 'package:UniqueBBSFlutter/widget/login/login.dart';
import 'package:UniqueBBSFlutter/widget/login/pw_set.dart';
import 'package:UniqueBBSFlutter/widget/post/detail/post_detail.dart';
import 'package:flutter/material.dart';

class BBSRoute {
  static final main = '/'; // 主页

  static final home = 'home'; // 首页
  static final information = 'information'; // 首页-情报
  static final forum = 'forum'; // 首页-论坛
  static final search = 'search'; // 首页-搜索
  static final selectPlate = 'select plate';

  static final login = 'login'; // 登录

  static final postList = 'postList'; // 帖子列表：首页-情报-通知公告、首页-我的-我的帖子
  static final postDetail = 'postDetail'; // 帖子详情
  static final posting = 'postReport'; // 发帖

  static final pwUpdate = 'pwUpdate'; // 修改密码
  static final pwSet = 'pwSet'; // 设置密码
  static final infoSet = 'infoSet'; // 用户信息设置

  static final message = 'message'; // 消息页面

  // TODO: 不需要传参的路由在这里进行声明
  static final routes = {
    home: (context) => HomeWidget(),
    selectPlate: (context) => HomeSelectWidget(),
    login: (context) => LoginWidget(),
    pwSet: (context) => PasswordSetWidget(),
    infoSet: (context) => InfoSetWidget(),
  };

  static Route buildPage(String path, dynamic arg) {
    if (routes.containsKey(path)) {
      return MaterialPageRoute(builder: routes[path]);
    }
    // used for build page with arguments
    // now only throw an exception
    if (path == postDetail) {
      return MaterialPageRoute(
          builder: (context) => PostDetailWidget(arg as Thread));
    }
    throw Exception("Route $path not found!");
  }
}
