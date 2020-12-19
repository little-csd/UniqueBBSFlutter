import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/config/route.dart';
import 'package:UniqueBBSFlutter/data/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

const _bottomPadding = 30.0;

/// 初始化的加载页, 可以用来做很多初始化工作
class AppSplashWidget extends StatelessWidget {
  void _init(BuildContext context) {
    final tokenErrCallback =
        () => Navigator.popAndPushNamed(context, BBSRoute.login);
    final initCallback = (bool ok, String msg) {
      if (ok) {
        Navigator.pushNamed(context, BBSRoute.home);
        Fluttertoast.showToast(msg: StringConstant.LoginSuccess);
      } else {
        Navigator.pushNamed(context, BBSRoute.login);
        Fluttertoast.showToast(msg: msg);
      }
    };
    Server.instance.init(initCallback, tokenErrCallback);
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
                  SvgIcon.logo,
                  color: ColorConstant.primaryColorTransparent,
                  alignment: Alignment.center,
                ),
              ),
              Text('UNIQUE\nSTUDIO', style: uniqueStudioTextStyle),
            ],
          ),
          Text('联创团队', style: bottomTextStyle),
        ],
      ),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(height: 20),
        Text('联创团队'),
        // Stack(
        //   alignment: Alignment.bottomCenter,
        //   children: [
        //     Text('UNIQUE\nSTUDIO'),
        //     SvgPicture.asset(
        //       SvgIcon.logo,
        //       fit: BoxFit.cover,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
