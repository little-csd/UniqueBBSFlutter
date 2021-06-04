import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:unique_bbs/config/constant.dart';
import 'package:unique_bbs/config/route.dart';
import 'package:unique_bbs/data/dio.dart';
import 'package:unique_bbs/widget/common/filled_text_field.dart';
import 'package:unique_bbs/widget/common/network_error_bottom_sheet.dart';
import 'package:unique_bbs/widget/common/normal_bottom_sheet.dart';

class LoginWidget extends StatefulWidget {
  @override
  State createState() => _LoginState();
}

class _LoginState extends State<LoginWidget> {
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(SvgIcon.loginLogo),
            _buildLogoText(StringConstant.logo2Line),
            Container(height: 67),
            _buildLoginTextField(
                StringConstant.phoneNumber, false, (str) => _username = str),
            Container(height: 20),
            _buildLoginTextField(
                StringConstant.password, true, (str) => _password = str),
            Container(height: 63),
            _buildLoginButton(context, _onLogin),
            Container(height: 15),
            _buildWeComLoginButton(context),
          ],
        ),
      ),
    );
  }

  void _onLogin() async {
    if (_username.isEmpty) {
      Fluttertoast.showToast(msg: StringConstant.usernameEmpty);
      return;
    } else if (_password.isEmpty) {
      Fluttertoast.showToast(msg: StringConstant.passwordEmpty);
      return;
    }

    /// 'ssski', 'Conceited67'
    Server.instance.login(_username, _password).then((rsp) {
      if (!rsp.success) {
        Fluttertoast.showToast(msg: rsp.msg);
      } else {
        Fluttertoast.showToast(msg: StringConstant.loginSuccess);
        Navigator.of(context).popAndPushNamed(BBSRoute.home);
      }
    });
  }
}

_buildNoNumberBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return NormalBottomSheetContainer(
            bottomCardRadius: 30,
            totalHeight: 436,
            pictureSrc: SvgIcon.error,
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
                  Text(StringConstant.noPhoneNumber),
                  Container(
                    height: 30,
                  ),
                  buildIKnowButton(context),
                  Container(
                    height: 16,
                  ),
                  _buildWeComLoginButton(context),
                ],
              ),
            ));
      });
}

_buildLoginButton(BuildContext context, VoidCallback callback) => SizedBox(
      width: double.infinity,
      child: FlatButton(
        height: 44,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: ColorConstant.primaryColor,
        child: Text(
          StringConstant.login,
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 22,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        onPressed: callback,
      ),
    );

_buildWeComLoginButton(BuildContext context) => SizedBox(
      width: double.infinity,
      child: FlatButton(
        height: 44,
        shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorConstant.weComButtonGray),
            borderRadius: BorderRadius.circular(20.0)),
        child: Text(
          StringConstant.useWeComLogin,
          style: TextStyle(
              fontSize: 15,
              letterSpacing: 1,
              color: ColorConstant.textLightBlack,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Fluttertoast.showToast(msg: StringConstant.notImpl);
        },
      ),
    );

_buildLoginTextField(
        String hint, bool obscure, ValueChanged<String> callback) =>
    FilledTextField(
      hint: hint,
      radius: Radius.circular(50),
      filledColor: ColorConstant.inputPurple,
      hintColor: ColorConstant.inputHintPurple,
      obscureText: obscure,
      onChanged: callback,
    );

_buildLogoText(String text) => Text(
      text,
      style: TextStyle(
        color: ColorConstant.textForLogo,
        fontSize: 18,
        letterSpacing: 2,
      ),
    );
