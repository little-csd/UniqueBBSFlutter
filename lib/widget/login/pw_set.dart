import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/config/route.dart';
import 'package:UniqueBBSFlutter/widget/common/FilledTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordSetWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PasswordSetWidget();
}

class _PasswordSetWidget extends State<PasswordSetWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(SvgIcon.doubt),
            Container(height: 20,),
            _buildLogoText(StringConstant.completePasswordLabel),
            Container(height: 42,),
            _buildPwSetTextField(StringConstant.password),
            Container(height: 20,),
            _buildPwSetTextField(StringConstant.confirmPassword),
            Container(height: 15,),
            _buildLogoText(StringConstant.passwordTips),
            Container(height: 67,),
            _buildFinishButton(context),
          ],
        ),
      ),
    );
  }
}

_buildFinishButton(BuildContext context) => SizedBox(
  width: double.infinity,
  child: FlatButton(
    height: 44,
    shape:
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    color: ColorConstant.primaryColor,
    child: Text(
      StringConstant.complete,
      style: TextStyle(color: Colors.white, letterSpacing: 10),
    ),
    onPressed: () {
      Navigator.pushNamed(context, BBSRoute.infoSet);
    },
  ),
);

_buildPwSetTextField(String hint) => buildFilledTextField(
    hint,
    Radius.circular(50),
    ColorConstant.inputPurple,
    ColorConstant.inputHintPurple
);


_buildLogoText(String text) => Text(
  text,
  style: TextStyle(
    color: Color(0xff727272),
    fontSize: 14,
    letterSpacing: 4,
  ),
);
