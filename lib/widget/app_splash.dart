import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/config/route.dart';
import 'package:UniqueBBSFlutter/data/dio.dart';
import 'package:UniqueBBSFlutter/data/repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

const _bottomPadding = 30.0;

/// 初始化的加载页, 可以用来做很多初始化工作
class AppSplashWidget extends StatelessWidget {
  void _init(BuildContext context) {
    Server.instance.init().then((errno) {
      if (errno == '') {
        Navigator.popAndPushNamed(context, BBSRoute.home);
        Fluttertoast.showToast(msg: StringConstant.loginSuccess);
      } else {
        Navigator.pushNamed(context, BBSRoute.login);
        Fluttertoast.showToast(msg: errno);
      }
    });
    getApplicationDocumentsDirectory()
        .then((dir) => Repo.instance.localPath = dir.path);
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
              Container(
                width: size,
                height: size,
                child: SvgPicture.asset(
                  SvgIcon.splashLogo,
                  color: ColorConstant.primaryColorTransparent,
                  alignment: Alignment.center,
                ),
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
