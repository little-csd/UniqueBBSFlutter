import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginWidget extends StatefulWidget {
  @override
  State createState() => _LoginState();
}

class _LoginState extends State<LoginWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center (
            child: Column (
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 116, 0, 0),
                  child: SvgPicture.asset("images/logo_login.svg",
                    width: 135,
                    height: 61,
                  ),
                ),

                LogoText("UNIQUE"),

                LogoText("STUDIO"),
                
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 68, 20, 0),
                  child: LoginTextField("手机号")
                ),

                Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: LoginTextField("密码"),
                ),
                
                Padding(
                  padding: EdgeInsets.fromLTRB(255, 7, 28, 0),
                  child: Text("输入错误",
                    style: TextStyle(
                      color: Colors.red
                    ),
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 39, 20, 0),
                  child:
                    SizedBox(
                      width: double.infinity,
                      child: FlatButton(
                        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                        color: Colors.pinkAccent,
                        child: Text("登陆"),
                        onPressed: () {},
                      ),
                    )
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child:
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                      color: Colors.pinkAccent,
                      child: Text("企业微信登录"),
                      onPressed: () {},
                    ),
                  )
                )
              ],
            )
      )
    );
  }
}

class LogoText extends Text {
  LogoText(String data) : super(data);

  @override
  TextStyle get style => TextStyle(
    color: Color(0xff727272),
    fontSize: 18,
    letterSpacing: 4
  );

}

class LoginTextField extends TextField {
  
  String fint;
  
  LoginTextField(String fint) {
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
        fillColor: Color(0xffECECEC),
        hintText: fint,
        hintStyle: TextStyle(
            color: Color(0xffb5b5b5),
        ),
        isDense: true,
    contentPadding: EdgeInsets.all(10)
      );
}


