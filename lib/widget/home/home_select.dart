import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:unique_bbs/config/constant.dart';
import 'package:unique_bbs/config/route.dart';
import 'package:unique_bbs/data/model/forum_model.dart';

// TODO: 这里大小最好是根据屏幕长宽去计算，可能会 overflow
const _cancelButtonSize = 40.0;
const _selectBtnSize = 80.0;
const _selectBtnRadius = 130.0;
const _animationDuration = 600;
final _emptyContainer = Container(height: 15);
const _btnTextStyle = TextStyle(
  fontSize: 18,
  color: ColorConstant.textMediumBlack,
  letterSpacing: 1,
  fontWeight: FontWeight.bold,
);
const _selectTextStyle = TextStyle(
  fontSize: 18,
  color: ColorConstant.textLightGrey,
  decoration: TextDecoration.none,
  letterSpacing: 2,
  fontWeight: FontWeight.bold,
);
const _btnBoxShadow = BoxShadow(
  offset: Offset(0, 3),
  color: ColorConstant.borderPurple,
  blurRadius: 10,
);

/// 展示的 item 名字以及对应的 forum
const forumData = [
  ['项目\n任务', StringConstant.uniqueProject],
  ['闲杂\n讨论', StringConstant.discussion],
  ['联创\n趣梗', StringConstant.notImpl],
  ['知识\n分享', StringConstant.uniqueShare],
  ['新人\n任务', StringConstant.freshmanTask],
  ['report', StringConstant.report],
  ['通知\n公告', StringConstant.broadcast],
  ['文件\n留存', StringConstant.uniqueData],
  ['奇思\n妙想', StringConstant.notImpl],
];

Widget _wrapData(
    BuildContext context, String data, String name, ForumModel model) {
  return Container(
    height: _selectBtnSize,
    decoration:
        BoxDecoration(boxShadow: [_btnBoxShadow], shape: BoxShape.circle),
    child: MaterialButton(
      onPressed: () {
        if (name == StringConstant.report) {
          Navigator.of(context)
              .popAndPushNamed(BBSRoute.postReport, arguments: null);
          return;
        }
        Fluttertoast.showToast(msg: StringConstant.notImpl);
        Navigator.of(context).pop();
      },
      color: ColorConstant.backgroundWhite,
      shape: const CircleBorder(),
      elevation: 0,
      child: Text(data, style: _btnTextStyle),
    ),
  );
}

Widget _wrapTransform(Widget child, double angle, double radius) {
  double dx = sin(angle) * radius;
  double dy = cos(angle) * radius;
  return Container(
    transform: Matrix4.translationValues(dx, -dy, 0),
    alignment: Alignment.center,
    child: child,
  );
}

Widget _buildCircularWidget(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return Container(
    width: size.width,
    height: size.width,
    alignment: Alignment.center,
    child: Consumer<ForumModel>(builder: (context, model, child) {
      var widgets =
          forumData.map((e) => _wrapData(context, e[0], e[1], model)).toList();
      double deltaAngle = 2 * pi / (forumData.length - 1);
      widgets[0] = _wrapTransform(widgets[0], 0, 0);
      for (int i = 1; i < forumData.length; i++) {
        widgets[i] =
            _wrapTransform(widgets[i], deltaAngle * (i - 1), _selectBtnRadius);
      }
      return Stack(children: widgets);
    }),
  );
}

Widget _buildCancelButton(
    BuildContext context, AnimationController controller) {
  return Container(
    child: AnimatedBuilder(
      builder: (context, child) {
        final value = controller.value;
        final btnColor = Color.lerp(
            ColorConstant.backgroundWhite, ColorConstant.primaryColor, value);
        return Hero(
          tag: StringConstant.selectPlateHero,
          child: GestureDetector(
            onTap: () => Navigator.pop(context, ''),
            child: Transform.rotate(
              angle: pi / 4 * value,
              child: SvgPicture.asset(
                SvgIcon.homeBottomBtn,
                height: _cancelButtonSize,
                width: _cancelButtonSize,
                color: btnColor,
              ),
            ),
          ),
        );
      },
      animation: controller,
    ),
  );
}

class HomeSelectWidget extends StatefulWidget {
  @override
  State createState() => _HomeSelectState();
}

class _HomeSelectState extends State<HomeSelectWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: _animationDuration))
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundLightGrey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            StringConstant.selectBlockHint,
            style: _selectTextStyle,
          ),
          _emptyContainer,
          SvgPicture.asset(SvgIcon.selectPlateIcon),
          _buildCircularWidget(context),
          _emptyContainer,
          _buildCancelButton(context, _controller),
          _emptyContainer,
        ],
      ),
    );
  }
}
