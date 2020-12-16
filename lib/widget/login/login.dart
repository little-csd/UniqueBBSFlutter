import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:UniqueBBSFlutter/widget/common/FilledTextField.dart';


// todo: refactor
class LoginWidget extends StatefulWidget {
  @override
  State createState() => _LoginState();
}

class _LoginState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(0, 116, 0, 0),
              child: SvgPicture.asset(
                "images/login_logo.svg",
              ),
            ),
            _LogoText("UNIQUE"),
            _LogoText("STUDIO"),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 68, 20, 0),
                child: _buildLoginTextField("登陆")
                ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _buildLoginTextField("密码"),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 63, 20, 0),
                child: SizedBox(
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
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    height: 44,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: ColorConstant.skyButtonGray),
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Text("使用企业微信扫码登录"),
                    onPressed: () {
                      // fixme: test code
                      textBottomSheet(context);
                      // todo: route to WeCom Page
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }

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

class _LogoText extends Text {
  _LogoText(String data) : super(data);

  @override
  TextStyle get style => TextStyle(
    color: Color(0xff727272),
    fontSize: 18,
    letterSpacing: 4
  );
}

_buildLoginTextField(String hint) =>
    buildFilledTextField(
        hint,
        Radius.circular(50),
        ColorConstant.skyInputPurple,
        ColorConstant.skyInputHintPurple
    );
