import 'package:UniqueBBS/config/constant.dart';
import 'package:UniqueBBS/widget/common/filled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InfoSetWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InfoSetWidgetState();
}

class InfoSetWidgetState extends State<InfoSetWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(SvgIcon.setInfo),
            Container(
              height: 11,
            ),
            _buildLogoText(StringConstant.userInfoLabel),
            Container(
              height: 41,
            ),
            _buildInfoSetTextField(StringConstant.password),
            Container(
              height: 20,
            ),
            _buildInfoSetTextField(StringConstant.confirmPassword),
            Container(
              height: 48,
            ),
            _buildNextStepButton(context),
            Container(
              height: 14,
            ),
            _buildJumpOverButton(context),
          ],
        ),
      ),
    );
  }
}

_buildNextStepButton(BuildContext context) => SizedBox(
      width: double.infinity,
      child: FlatButton(
        height: 44,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: ColorConstant.primaryColor,
        child: Text(
          StringConstant.nextStep,
          style: TextStyle(color: Colors.white, letterSpacing: 10),
        ),
        onPressed: () {},
      ),
    );

_buildJumpOverButton(BuildContext context) => SizedBox(
      width: double.infinity,
      child: FlatButton(
        height: 44,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.white,
        child: Text(
          StringConstant.jumpOver,
          style: TextStyle(
              color: ColorConstant.textLightPurPle, letterSpacing: 10),
        ),
        onPressed: () {},
      ),
    );

_buildInfoSetTextField(String hint) => FilledTextField(
      hint: hint,
      radius: Radius.circular(50),
      filledColor: ColorConstant.inputPurple,
      hintColor: ColorConstant.inputHintPurple,
      obscureText: false,
    );

_buildLogoText(String text) => Text(
      text,
      style: TextStyle(
        color: Color(0xff727272),
        fontSize: 14,
        letterSpacing: 4,
      ),
    );
