import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


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
                child: _LoginTextField("手机号")),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: _LoginTextField("密码"),
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
                      // todo: route to WeCom Page
                    },
                  ),
                ))
          ],
        ),
      ),
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

class _LoginTextField extends TextField {

  String fint;

  _LoginTextField(String fint) {
    this.fint = fint;
  }

  @override
  TextStyle get style => TextStyle(
        fontSize: 14,
        letterSpacing: 2,
      );

  @override
  InputDecoration get decoration => InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffffffff)),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffffffff)),
            borderRadius: BorderRadius.all(Radius.circular(50))),
        filled: true,
        fillColor: ColorConstant.skyInputPurple,
        hintText: fint,
        hintStyle: TextStyle(
            color: Color(0xffb5b5b5),
        ),
        isDense: true,
      contentPadding: EdgeInsets.all(10),
      );
}


