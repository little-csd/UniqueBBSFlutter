import 'dart:math';

import 'package:UniqueBBSFlutter/config/constant.dart';
import 'package:UniqueBBSFlutter/data/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

// TODO: 这里大小最好是根据屏幕长宽去计算，可能会 overflow
const _cancelButtonSize = 40.0;
const _selectBtnSize = 80.0;
const _selectBtnRadius = 130.0;
const _animationDuration = 600;
final emptyContainer = Container(height: 15);
final _btnTextStyle = TextStyle(
  fontSize: 20,
  color: ColorConstant.textBlack,
);
final _selectTextStyle = TextStyle(
  fontSize: 20,
  color: ColorConstant.textGrey,
  decoration: TextDecoration.none,
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

Widget _wrapData(BuildContext context, String data, String name) {
  return MaterialButton(
    onPressed: () {
      if (name == StringConstant.notImpl || name == StringConstant.report) {
        Fluttertoast.showToast(msg: name);
      } else {
        final model = Repo.instance.forumModel;
        final forum = model.findByName(name);
        if (forum == null) {
          Fluttertoast.showToast(msg: StringConstant.networkError);
        } else {
          print(forum.toJson());
        }
      }
      Navigator.of(context).pop();
    },
    color: ColorConstant.backgroundWhite,
    shape: const CircleBorder(),
    height: _selectBtnSize,
    child: Text(data, style: _btnTextStyle),
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
  var widgets = forumData.map((e) => _wrapData(context, e[0], e[1])).toList();
  double deltaAngle = 2 * pi / (forumData.length - 1);
  widgets[0] = _wrapTransform(widgets[0], 0, 0);
  for (int i = 1; i < forumData.length; i++) {
    widgets[i] =
        _wrapTransform(widgets[i], deltaAngle * (i - 1), _selectBtnRadius);
  }
  final size = MediaQuery.of(context).size;
  return Container(
    width: size.width,
    height: size.width,
    alignment: Alignment.center,
    child: Stack(
      children: widgets,
    ),
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
          emptyContainer,
          SvgPicture.asset(SvgIcon.selectPlateIcon),
          emptyContainer,
          _buildCircularWidget(context),
          emptyContainer,
          _buildCancelButton(context, _controller),
          emptyContainer,
        ],
      ),
    );
  }
}
