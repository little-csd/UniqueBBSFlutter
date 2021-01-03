import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/config/route.dart';
import 'package:UniqueBBS/data/dio.dart';
import 'package:UniqueBBS/data/repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

const _bottomPadding = 30.0;

/// 初始化的加载页, 可以用来做很多初始化工作
/// Warning: 测试的时候发现，使用 run 的话，这里界面会被 build 两次
/// 这样再次调用 init 就会导致重复请求更新 jwt，出现一些奇怪的现象
class AppSplashWidget extends StatelessWidget {
  void _init(BuildContext context) {
    // 初始化本地文件存储路径
    getApplicationDocumentsDirectory()
        .then((dir) => Repo.instance.localPath = dir.path);
    Server.instance.init().then((errno) {
      if (errno.isEmpty) {
        Navigator.popAndPushNamed(context, BBSRoute.home);
        Fluttertoast.showToast(msg: StringConstant.loginSuccess);
      } else {
        Navigator.popAndPushNamed(context, BBSRoute.login);
        Fluttertoast.showToast(msg: errno);
      }
    });
  }

  final uniqueStudioTextStyle = TextStyle(
    fontSize: 20,
    color: ColorConstant.textBlack,
    decoration: TextDecoration.none,
    letterSpacing: 2,
  );
  final bottomTextStyle = TextStyle(
    fontSize: 20,
    color: ColorConstant.textBlack,
    decoration: TextDecoration.none,
    letterSpacing: 10,
  );

  @override
  Widget build(BuildContext context) {
    _init(context);
    final size = MediaQuery.of(context).size.width;
    return Container(
      color: ColorConstant.backgroundLightGrey,
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.only(bottom: _bottomPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset(
                PngIcon.splashLogo,
                width: size,
                height: size,
              ),
              Text(StringConstant.logo2Line, style: uniqueStudioTextStyle),
            ],
          ),
          Text(StringConstant.uniqueStudio, style: bottomTextStyle),
        ],
      ),
    );
  }
}
