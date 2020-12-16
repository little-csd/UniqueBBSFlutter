import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/tool/helper.dart';
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
            _buildWeComLoginButton(),
          ],
        ),
      ),
    );
  }

  // todo : delete test code
  void textBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: 330,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(30),
                topRight: const Radius.circular(30),
              ),
            ),
            child: Text("circle"),
          );
        }
    );
  }
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

_buildWeComLoginButton() =>
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
