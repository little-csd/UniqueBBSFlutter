import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/widget/app_splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/route.dart';
import 'data/repo.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Repo.instance!.userModel),
        ChangeNotifierProvider(create: (context) => Repo.instance!.forumModel),
        ChangeNotifierProvider(create: (context) => Repo.instance!.avatarModel),
      ],
      child: UniqueStudioApp(),
    ),
  );
}

// 初始进入 app 有三种页面:
// 1. 登录页: 当前为未登录状态(未持有 token)
// 2. splash 页面: 正在登录(已发起请求)
// 3. 主页: 当前为已登录状态(持有 token)
class UniqueStudioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: ColorConstant.backgroundLightGrey,
          iconTheme: IconThemeData(
            color: ColorConstant.textGrey,
          ),
        ),
        accentColor: ColorConstant.accentColor,
        indicatorColor: ColorConstant.primaryColor,
        iconTheme: IconThemeData(color: ColorConstant.primaryColor),
        primaryTextTheme:
            TextTheme(bodyText2: TextStyle(color: ColorConstant.primaryColor)),
        primaryColor: ColorConstant.primaryColor,
        primaryColorLight: ColorConstant.primaryColorLight,
        unselectedWidgetColor: ColorConstant.textGrey,
        fontFamily: 'PingFang',
      ),
      home: AppSplashWidget(),
      onGenerateRoute: (setting) =>
          BBSRoute.buildPage(setting.name, setting.arguments),
    );
  }
}
