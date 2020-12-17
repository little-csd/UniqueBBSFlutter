import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/tool/helper.dart';
import 'package:UniqueBBSFlutter/widget/common/NormalBottomSheetContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:UniqueBBSFlutter/widget/common/FilledTextField.dart';

class LoginWidget extends StatefulWidget {
  @override
  State createState() => _LoginState();
}

class _LoginState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:EdgeInsets.only(
            left: 20,
            right: 20
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "images/login_logo.svg",
            ),
            _LogoText("UNIQUE\nSTUDIO"),
            Container(height: 67,),
            _buildLoginTextField("用户名"),
            Container(height: 20,),
            _buildLoginTextField("密码"),
            Container(height: 63,),
            _buildLoginButton(),
            Container(height: 15,),
            _buildWeComLoginButton(context),
          ],
        ),
      ),
    );
  }

}

_buildLoginBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return _buildBottomSheetBody2(context);
      }
  );
}

_buildBottomSheetBody2(BuildContext context) {
  return NormalBottomSheetContainer(
    bottomCardRadius: 30,
    totalHeight: 436,
    pictureSrc: "images/no_phone_number.svg",
    bottomSheetHeight: 294,
    bottomSheetTopPadding: 55,
    childInternal: Container(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
      ),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
         Text("手机号未注册，\n用企业微信登录试试吧？"),
         Container(height: 30,),
         _buildIKnowButton(),
         Container(height: 16,),
         _buildWeComLoginButton(context),
       ],
     ),
    )
  );
}

_buildLoginButton() =>
    SizedBox(
      width: double.infinity,
      child: FlatButton(
        height: 44,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)),
        color: ColorConstant.primaryColor,
        child: Text(
          "登陆",
          style: TextStyle(color: Colors.white, letterSpacing: 22),
        ),
        onPressed: () {
          // todo: login internal
        },
      ),
    );

_buildIKnowButton() =>
    SizedBox(
      width: double.infinity,
      child: FlatButton(
        height: 44,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0)),
        color: ColorConstant.primaryColor,
        child: Text(
          "我知道了",
          style: TextStyle(color: Colors.white, letterSpacing: 22),
        ),
        onPressed: () {
          // todo: login internal
        },
      ),
    );

_buildWeComLoginButton(BuildContext context) =>
    SizedBox(
      width: double.infinity,
      child: FlatButton(
        height: 44,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorConstant.skyButtonGray),
            borderRadius: BorderRadius.circular(20.0)),
        child: Text("使用企业微信扫码登录"),
        onPressed: () {
          // todo: route to WeCom Page
          _buildLoginBottomSheet(context);
        },
      ),
    );

_buildLoginTextField(String hint) =>
    buildFilledTextField(
        hint,
        Radius.circular(50),
        ColorConstant.skyInputPurple,
        ColorConstant.skyInputHintPurple
    );

class _LogoText extends Text {
  _LogoText(String data) : super(data);
  @override
  TextStyle get style => TextStyle(
      color: Color(0xff727272),
      fontSize: 18,
      letterSpacing: 4
  );
}
