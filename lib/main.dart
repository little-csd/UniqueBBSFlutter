import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/widget/home.dart';
import 'package:flutter/material.dart';

import 'config/route.dart';

void main() {
  runApp(MyApp());
}

// 登录模块完成后, 此处需要判断是否有保存的账号密码信息
// 初始进入 app 有三种页面:
// 登录状态使用 Provider 全局共享
// 1. 登录页: 当前为未登录状态(未持有 token)
// 2. splash 页面: 正在登录(已发起请求)
// 3. 主页: 当前为已登录状态(持有 token)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: ColorConstant.backgroundGray,
            iconTheme: IconThemeData(
              color: ColorConstant.textGray,
            ),
          ),
          accentColor: ColorConstant.accentColor,
          indicatorColor: ColorConstant.primaryColor,
          iconTheme: IconThemeData(color: ColorConstant.primaryColor),
          primaryTextTheme: TextTheme(
              bodyText2: TextStyle(color: ColorConstant.primaryColor)),
          primaryColor: ColorConstant.primaryColor,
          primaryColorLight: ColorConstant.primaryColorLight,
          unselectedWidgetColor: ColorConstant.textGray),
      home: HomeWidget(),
      onGenerateRoute: (setting) =>
          BBSRoute.buildPage(setting.name, setting.arguments),
    );
  }
}
